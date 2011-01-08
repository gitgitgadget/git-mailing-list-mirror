From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: different name and email address depending on folder
Date: Sat, 8 Jan 2011 13:09:30 +0530
Message-ID: <20110108073928.GD27334@kytes>
References: <3178E076-FA22-4C3C-BEB2-2581A0E12086@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rich Eakin <reakinator@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 08:38:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbTNx-0002mk-Nu
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 08:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936Ab1AHHi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 02:38:29 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49071 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab1AHHi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 02:38:28 -0500
Received: by iwn9 with SMTP id 9so17848897iwn.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 23:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kpzbvMjmCCjZD61xpVot5aL2wAuxs3xzAk3IxOZJ0XA=;
        b=kA9fscUh9Cn/03+vy6oqs4VfwruBNaEZh8Cckovitt9QNN4o4QMQQS1oZu4DPaUt+7
         mk4qm2FmkUBinVaAS748DymVTuZiBrrfTFDKLN3YTWKW3IUJlAsjAEglnAaK4DjlVLyN
         bMPAqkO/JMd5aAqzPxUOEspCrmgzQpqgdP3HA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PwC4if3PwAu8y6Lv2JNIfZommP7jVt+hi2vE1fJQkLEAZnmTUzNkYYY4vejqGb2AUb
         Ymnp9Qr8Ix4dwb8BdXNDasnSjGlgtvYHCQdbuIdL6+AGTM6fd0LyilxNc2FvnDtbtwQA
         aqV3qXMPOru/y7BKRXQGQ7h4V8ajmLj4MQA/M=
Received: by 10.42.240.66 with SMTP id kz2mr1781453icb.340.1294472307430;
        Fri, 07 Jan 2011 23:38:27 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id f5sm763528icu.4.2011.01.07.23.38.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 23:38:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3178E076-FA22-4C3C-BEB2-2581A0E12086@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164808>

Hi Rich,

Rich Eakin writes:
> I am using git for development with a company and myself on the same computer and the name / user fields need to be different for each.  As I keep all my company's repos in one directory and my private stuff in another, I was wondering if there is a way to tell git to use a separate user and email whenever I make commits from within a specified directory.  

Yes. Please see the 'user.name' and 'user.email' configuration options
in git-config(1). You can set them globally or on a per-repository
basis.

-- Ram
