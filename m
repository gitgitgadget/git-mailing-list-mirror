From: =?UTF-8?B?7J2A6rWQ?= <eunqyo@gmail.com>
Subject: Can I change Git binary file's name when deploying Git-based product?
Date: Tue, 19 Jan 2016 17:07:16 +0900
Message-ID: <CACaY5-uUqFxsRdwPzxAjphc=wNQhM76YJFmCZu86SpGeG1fOrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 09:07:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLRJz-0006Li-M1
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 09:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbcASIHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 03:07:20 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36079 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757332AbcASIHS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 03:07:18 -0500
Received: by mail-lb0-f182.google.com with SMTP id oh2so359563618lbb.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 00:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=kgs0DdrQ1Bd7S3GCi3CA4SFsGduDW84kxwC7H5J1eQw=;
        b=n2m9NJ9wbSB28Nsxz9FGiTE3E/TzgVSadY+yIrmMOROrwI+cHEtXvcI9hcPgQqTcwZ
         zShkTQknzo2qmUVfjUFEvs5D3K9GbDQvImoQNagrPb7k1v+1/J9w9q+SX/vF/G1mpZ2D
         R17iFrHiMD6OhNC5ZpUBaXIgn3/jrCfD5UVmMyzg3k5gx5kmsX4ARc9I6XHsunu54Oqy
         PQyLz4WPXRDNtLLvL6kS5xgQQaE3daH501slhjH70ioVo46nVstXLdT5zIRlPTP0M/0I
         h+ffV+I88+PMSH4ZZ758ivudWfTdZs7m1vW8lx0+spZFPaSeGgiSoQVHFZPDf/iYoUJy
         1wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=kgs0DdrQ1Bd7S3GCi3CA4SFsGduDW84kxwC7H5J1eQw=;
        b=kj0AefsSEFZMS7T6uAJBAbikDsc60Qa5G2j3AfbwEVtzRZq655bcbP2L3GLvyjTNAC
         86L0On48M01h/sm2oJs8QLTFq9G7a2qaDi3TkE1UbWUBJDUQhvU/LqZ8SPfjR9Jly+NI
         3c0iNZPbdXYg0XG3SK9gYP02u99UMfSDXnuSHNQb8spyeeKSw9XUS/iCBVM8O2uBfG5X
         9Ouv9ULK31gfXBh/0/Qjmz3uGD5mR69p6p0QCnXGuIC5ZMIhFwVPKNo/sVnYiluGjgUv
         f7pixCReJ3ONyV3Fv8EqB3wUPi5WmfBQMcfIh3y5+FZv+cFHV75wEEYJgsQ1Oik3GKc0
         ms3Q==
X-Gm-Message-State: ALoCoQndW8Ugu3m397HjlK4VBt74B64sFAGZv9r8p7h9qNeOBY4wZO/de+SAboaTkeCCKEwFZpeofSItJCS9tipM1ScFFqA8Dg==
X-Received: by 10.112.198.102 with SMTP id jb6mr9990427lbc.44.1453190837011;
 Tue, 19 Jan 2016 00:07:17 -0800 (PST)
Received: by 10.25.39.132 with HTTP; Tue, 19 Jan 2016 00:07:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284350>

Hi, my name is Jae Kwon Han.
I am developing Version Control program for designers called 'Indegs'.
Indegs is using Git binary file in my product to version control design files.

Problem is that whenever git command is executed, 'The Git command
requires the command line developer tools. Would you like to install
the tools now?' message comes out.

I found out that when i change Git binary file's name that my product
is executing, problem is solved. Since then i tried to read every
licenses regarding Git but can't find a clear answer.

Can i change Git binary file's name to for example 'Git-indegs',
'Indegs' when deploying my product?
