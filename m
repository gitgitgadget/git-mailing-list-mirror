From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: clean the manual of unnecessary quote marks
Date: Fri, 28 Nov 2008 07:25:53 +0100
Message-ID: <bd6139dc0811272225ybc8aa21lf67a0f226f5d2e53@mail.gmail.com>
References: <87fxlcwqhv.fsf@jidanni.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Nov 28 07:27:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5wp1-0005ek-4y
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 07:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbYK1GZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 01:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbYK1GZz
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 01:25:55 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:36946 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbYK1GZy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 01:25:54 -0500
Received: by yx-out-2324.google.com with SMTP id 8so533787yxm.1
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 22:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IBSRpri+1N7oBlfmFjhh2DUtoAP/5usqb2vInmTogJ8=;
        b=NcsTDzSkV90M4maAayVQzpCgdY1XKkpRa5kjZ72i+pPzBhJ65KHYnXPZooPSmKpcGQ
         /fWTUNMYCiKnQARC1VP2XYg+CZct+D4Isv+hZjtFRComBY9+tLHyAwUHjsi9FLpdLK5f
         XN3DnPmuI2HnoaAo/ISyyGwhR5rtypX2sADmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=lML+AsTCKXukQfcQgZdYczxssTA3Jq/U7CH8sn8XAFDDuQYslzjxSSX/jPs5JvSpDo
         4+SYy4iDO1WtAnqxq9ox8qxZHuHa6YQ2z8Hb1FMkr23uCzht6QkMlBok/n/rkL8YCp9h
         hhrezjWosWvRR6iqQiXlt7zmH7SMwSwme2mB4=
Received: by 10.150.11.6 with SMTP id 6mr3921086ybk.214.1227853553119;
        Thu, 27 Nov 2008 22:25:53 -0800 (PST)
Received: by 10.151.108.18 with HTTP; Thu, 27 Nov 2008 22:25:53 -0800 (PST)
In-Reply-To: <87fxlcwqhv.fsf@jidanni.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101864>

On Fri, Nov 28, 2008 at 03:09,  <jidanni@jidanni.org> wrote:
> $ git-cat-file "blob" 557db03
> which makes it look like the author is an expert in other things, but
> not the shell, where
> $ git-cat-file blob 557db03
> would be fine.

This I will agree with you, quoting blob is silly in this case...

>Do you really type those extra quotes when nobody else
> is looking? Same even with
> $ echo "Silly example" >example
> Let's see, Of
> $ echo Silly example >example
> $ echo Silly example>example
> $ echo Silly example > example
> I'd pick the latter...

But I don't agree here, with echo I do always write the extra quotes
when nobody is looking, I find your alternatives less clear than the
original (with the quotes).

-- 
Cheers,

Sverre Rabbelier
