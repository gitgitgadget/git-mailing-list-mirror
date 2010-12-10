From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git notes and git-commit
Date: Fri, 10 Dec 2010 13:11:14 -0600
Message-ID: <20101210191114.GB6210@burratino>
References: <AANLkTi=q1F7WEgH+dLKTHOKhsNVuhU=OeyJ2AsP7oW2G@mail.gmail.com>
 <201012101513.43890.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 20:11:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR8NX-0002iA-0T
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 20:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799Ab0LJTLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 14:11:34 -0500
Received: from mail-fx0-f66.google.com ([209.85.161.66]:37077 "EHLO
	mail-fx0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756383Ab0LJTLd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 14:11:33 -0500
Received: by fxm14 with SMTP id 14so1200665fxm.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 11:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=O7QkfGepQ5tmCg8N7wucfG135shCBM6cbYl75/Xs45E=;
        b=SeU19xK7XDY0vDiYcsR1Ql7o83aglu/l9dCKmk90MvmYEVGQRC5UfX8iE6Ds1cWRBK
         +IkPwv//6MgWlnCbdHaJzF50LvaKf7ZHvQFCiK+PrkTac3MBM9Ke6Sjjh0ZaQraxmsR3
         eKF5mo8NxBCHg61Ksi30pSS318ieDifq2njZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MXVG1W5EkHsQ1DULo2CIT98gH7CO63y1QFcpKxa0+WwKULdKm8EqdhqPDEi/JPyNbd
         v286DrDaStiK5i9r+SSv/EF0DrDOKQmd6wokCLTwHlv5F5thPTneq13ahhWHa9EkHkXZ
         aV9hXhk/Gi+cRkzsoffZbDAzW/rpFwb1P3SUw=
Received: by 10.223.96.66 with SMTP id g2mr1269137fan.61.1292008292396;
        Fri, 10 Dec 2010 11:11:32 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.sbcglobal.net [69.209.58.175])
        by mx.google.com with ESMTPS id y1sm1015939fak.39.2010.12.10.11.11.30
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 11:11:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201012101513.43890.johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163431>

Johan Herland wrote:

> That said, there might well be good use cases for this (e.g. using notes 
> to store data types - e.g. binary data - that cannot be part of the 
> commit message)

A small clarification: Can't binary data be part of the commit
message, too?  I suppose you mean "e.g. using notes to store data -
e.g. build products - that would be obnoxious to be unconditionally
shown by git log".
