From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: german translation bug
Date: Thu, 26 Dec 2013 08:58:16 -0800
Message-ID: <20131226165815.GR20443@google.com>
References: <1573480.3a5WD62Cc4@i5>
 <CAN0XMOJf=H__eFmbcBs-S50ASun94ASL9FiL1zM6eeTheYpxTg@mail.gmail.com>
 <1513689.dimJgKglhA@i5>
 <3869663.MXlVypzsjR@i5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Wolfgang Rohdewald <wolfgang@rohdewald.de>
X-From: git-owner@vger.kernel.org Thu Dec 26 17:59:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwEGj-00065e-5K
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 17:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab3LZQ6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 11:58:22 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:56265 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495Ab3LZQ6V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 11:58:21 -0500
Received: by mail-yh0-f42.google.com with SMTP id z6so1844836yhz.1
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 08:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Am01aCN0HJcVGXrmjXqWsmOMyrsC5CBobvcOOaLFq50=;
        b=HW8FUfZ0/lMXUBYE9xAsMoKxH2geQE7Z0XG1tRQZWBQVh0P6ZI0/9tFQ6TcnYTFrtf
         YymFievSRhe0EMt+EBAwKyTJlbv4cBmk7RF6+xOMWt6udgNQc2XfJ9dX3CKNL6KXyWeq
         Uv12wlmzgVG9E2Smib3lvoSRYRp5rzVKrdi5XlDpEXz5Vxxlr/pRT1shhH5pky4Vev+T
         zRxHbwLngLJJnu86XATtT8g9hfm2A93Eqdb24TaeuV6UXGJPVQ/dhEDhsWzWgVAu14O4
         UNS9Dyr3TeH8YCcJKorRzAYz4lckLLlOqsA2KN9xwZseiL85gtuCiHwwCT98ndwsT3/T
         E5Dw==
X-Received: by 10.236.112.242 with SMTP id y78mr5664917yhg.94.1388077099183;
        Thu, 26 Dec 2013 08:58:19 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id h66sm42448123yhb.7.2013.12.26.08.58.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 08:58:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3869663.MXlVypzsjR@i5>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239702>

Hi,

Wolfgang Rohdewald wrote:
> Am Mittwoch, 25. Dezember 2013, 22:53:29 schrieb Wolfgang Rohdewald:

>> I suppose I should open a KDE bug report?
>
> I meant a ubuntu bug report of course.

Yes, please.  Feel free to cc me if doing so.

In generally, I'm a bit uncomfortable lately at how Ubuntu's
translation system works for Git.  They are trying to solve a real
problem: old Ubuntu releases stick to old versions of git that do not
have as complete translations as the latest version.  But their
solution to this problem does not seem to work well and creates a lot
of confusion.  Worse, it creates duplicated effort, as their custom
translations don't seem to have been submitted upstream for review or
inclusion.
