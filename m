From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] Update 'git remote set-head' doc and uasage
Date: Fri, 27 Sep 2013 16:52:56 -0700
Message-ID: <20130927235256.GP9464@google.com>
References: <1379778706-5664-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Sep 28 01:53:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPhqL-0003eb-D8
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 01:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab3I0XxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 19:53:01 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:55182 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab3I0XxA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 19:53:00 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so3241652pdj.15
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 16:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8195vO3D9gDRsdIUTbk9ilM1BIjg+K8TrBbcH03I6SY=;
        b=trpFIc4JVmw4wbrihqTlB2nnjU4VJIPFbCSsJzYkfJDAlD+w+FIgzratZrvTPXkcW9
         a+oqaiO0zV3VbXzBJ/8xDd0QhMLxSOCON2cwvOlF2yQzJw65BGWvUTFAW8hGOxK5qcjj
         XXhxe9fZ8cuEezPlYTBumioDYw6cjpDFaCZOG0FMlZJ0RsJRTxKQY/H4BVDPQ1JoucgA
         E5ZFrtfGoD6ptl0Vnq46w1S4p/jL2GWQzYkPSHaq4Adqlf8o95+AYuotCyKGTWPr6AhQ
         GLppSQ+o4y9OlulDwm90z9g2dlBTV60JyuUXrj/7IuzeFTmE90BAcWJtCN6ftJIC6jTu
         +aew==
X-Received: by 10.66.25.102 with SMTP id b6mr14210407pag.129.1380325979848;
        Fri, 27 Sep 2013 16:52:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id tz3sm11257764pbc.20.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 16:52:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1379778706-5664-1-git-send-email-philipoakley@iee.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235480>

Philip Oakley wrote:

> In Junio's recent patch series ([PATCH v3 0/7] Removing the guesswork
> of HEAD in "clone" $gmane/234950), his first patch updated t5505: 'fix
> "set-head --auto with ambiguous HEAD" test'.
>
> A quick look at the git remote man page showed that --auto was not
> documented, nor listed in usage stings.

Thanks.
