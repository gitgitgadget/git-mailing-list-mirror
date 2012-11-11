From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Sun, 11 Nov 2012 22:42:58 +0530
Message-ID: <CALkWK0kvScgtqwCLA2BPZxs5qc-ZVyZPiCu6BHrqjne-Yfr8-A@mail.gmail.com>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 18:13:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXb6D-0002RM-Og
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903Ab2KKRNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 12:13:20 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:57957 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab2KKRNU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 12:13:20 -0500
Received: by mail-wi0-f178.google.com with SMTP id hr7so1793103wib.1
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 09:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hD1YmLYRLaBtqoN08z+uGPrIl1hvsypZaR+hiCVEa1A=;
        b=oVqYMkFiv5/HdtvGqcn+zRKZ0LRjX2y+FyzMUcHU+YR+4PzAr1avOLltFjfpanjlrF
         Xbw05HdDw7BGDudGcMKREkAewXO4pe19W5jhXDapb5Ubd3yEL/JCBLI5FvE974NHfmft
         zH+82A73WGPYejPLBnvvVT91550bAAibmxdYKrrl4avcM+DZWqkK4ZaWE3djZIMqTmXa
         21aprFuWq0WRy5wMogrSE1VFTpMev5IjXPlA0Zo+ooR8FfVc/Kv7jACIc6FqnRyNhB1N
         TRY33J61hKcHyAi5ZctcDNR3qLC/LSV9+sMZvmt9H4VojwjIfljBoTwVLz7MObUBHlkU
         mexQ==
Received: by 10.216.140.33 with SMTP id d33mr6865950wej.68.1352653999004; Sun,
 11 Nov 2012 09:13:19 -0800 (PST)
Received: by 10.217.61.2 with HTTP; Sun, 11 Nov 2012 09:12:58 -0800 (PST)
In-Reply-To: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209420>

Felipe Contreras wrote:
> I got really tired of 'git send-email' always asking me from which address to send mails... that's already configured.

Use sendemail.from.  The email sender doesn't necessarily have to be the author.

Ram
