From: Tim Visher <tim.visher@gmail.com>
Subject: Hosting from Windows XP.
Date: Mon, 26 Jan 2009 11:27:50 -0500
Message-ID: <c115fd3c0901260827ge5e4b29w871b345da2373f6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 17:29:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRULD-0000Kz-KZ
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 17:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbZAZQ1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 11:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbZAZQ1x
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 11:27:53 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:15320 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbZAZQ1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 11:27:52 -0500
Received: by an-out-0708.google.com with SMTP id c2so1223712anc.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 08:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=wy/z8/PPXS7w9B9JuExKMA4Z0RbmkC1il6LR6i1k/Yc=;
        b=XpwwPof8j2XdoIpYhOklWu+Le6p4yq0PBSwojTR/glfVHec8BLPbleYu2wysQG7z1q
         Or7Y0iik0IGnB93xnJO2MvlGzufqI/Cv+H+zMOjtG4AcehTXLZIkNZ3GPac/HR5IMRbj
         PnOo019XeDvgoLTlTO4I/ot71UqHN/EqFPkAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=lOukAAoKWG0cBnzeOvT3jx83tKAml4JIGySspHyVFGn6ej6j8w7tOU8qN4kGikMS+t
         1DmjwPF3D/BK0GbuJYjP96NHEZNZW82qy8hMKmGJN2nApqtBfkmzdvwYaJ1RSIfbfQMo
         kmqfxkVAdP+N8TuI4ZulvjavbMRE1zSEhExnk=
Received: by 10.100.9.19 with SMTP id 19mr4659253ani.8.1232987270554; Mon, 26 
	Jan 2009 08:27:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107227>

Hello Everyone,

I'm trying to get git set up for my company.  We're stuck using
Windows for the foreseeable future so for now I have to host the
central integration repository out of a Windows box.  I figured the
easiest way to do this, short of installing cygwin, would be to do a
simple msysgit install and then run git daemon with the relevant repo
copied over onto the server.  Then devs could track that repo.
However, it appears that msysgit does not install git daemon.

I may totally be missing something here, but I don't know what.  Short
of the question is, how do I host a repo out of Windows?

Thanks in advance!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
