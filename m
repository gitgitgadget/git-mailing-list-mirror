From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] git-diff.txt: strip the leading "--" from options
 template
Date: Wed, 24 Apr 2013 09:43:00 -0700
Message-ID: <20130424164300.GD4119@elie.Belkin>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 18:43:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV2mn-00060H-BU
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 18:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756270Ab3DXQnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 12:43:08 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:62554 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277Ab3DXQnH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 12:43:07 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so731393pde.37
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=okYXWxnV7SlMKr7mTacmuAultwMR6Fe3hhAip8orQM0=;
        b=lBTYFnCgqLHDp+N7AZNoHrs/KMPIBzvYY8fvyUacDKw6VqihV1mv/pD4voYAPu7hw1
         kNW6El2Gof2QrdycasC6IlDiTUo8VXxltTcQ6JxQlOTyB2FVHadM1t+fMJTSoqEHbZYi
         3RP4sn7pT8615d2DAZnRdQMBsEv7+D561GDRtabICuv2qL5lGZrZW5HttWxKP/pgyMv3
         e/wREUeiDt6A0DfDPFw3Mje8f6gfUF24yvHxh7W33o6bWeoRo7K0yCFxDLYEfOm3zUXL
         kYEi1qDZnfe8EOKJrJq2ntGubHC05BtHXO98KMjA8k4WlnKYE8s0bPElTb3+U/rgow2b
         PGNA==
X-Received: by 10.68.129.232 with SMTP id nz8mr48794041pbb.25.1366821786693;
        Wed, 24 Apr 2013 09:43:06 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id li15sm4327458pab.2.2013.04.24.09.43.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 09:43:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1366821216-20868-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222268>

Ramkumar Ramachandra wrote:

> It is imperative to specify options with the [options] template.

Why is it imperative?

Anyway, this looks like a good change.  With that sentence removed
or some other clarification,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
