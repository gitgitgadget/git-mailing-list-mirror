From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: [RFC/GSoC] Introduction
Date: Sat, 12 Mar 2016 12:29:10 +0530
Message-ID: <56E3BE3E.9070105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 07:59:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aedWE-0006SU-QN
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 07:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbcCLG7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 01:59:18 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36452 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbcCLG7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 01:59:16 -0500
Received: by mail-pa0-f54.google.com with SMTP id tt10so116986212pab.3
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 22:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=UyQ5rFzq2U06vVIcwYk7oOpLJdr6alWsQvSyJnkmGVY=;
        b=Alp9Q2U6trI390iDXNOFkKgBYw+EXmi8sK9ZfHdKwEFqDEdA5z8A8sg2fFwov9PEQN
         MIZH7jhB8XaBQ2r8N0221KWex5ENawIuSc7+HbEeRONOqv/9T4H9D/XbMue22tWzJnpj
         ibtSITVZ6gCgVUZyB/B7WWj5fvvdU2H08FanaDs4/1Pncq1/MiyBjQEGZSnnNIP+HemX
         /V/8JOj54N6zKD/JD1vdlFKHzTRRHFceOJ0kSPMmTwJryyo9voND+iOLy7nuWEr6F5dF
         BVicvEPyvnEDnxi0YZFqKXph5t05SAnavk5/UtvXGWzm9VisD1ncnDeIGbBknzAUhqog
         01rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=UyQ5rFzq2U06vVIcwYk7oOpLJdr6alWsQvSyJnkmGVY=;
        b=dyxmEvSPO4gEwQ5biD0NX4sclntbCV8WbmtbqwmLpSRPUCndwydy+65xyxoEToKLS4
         i/S1ar/DHMSvloskzvVeJm2LL6nr1AAjoqJflD10dj4IOg4WK6jS5u9qlDOTr7bObekA
         TOWM9isOEbZZieR20bHp6Iylq+gOKxKkyAbAVNB8N6EQ3VlG8VMgugvBwcOh1K3qGL1h
         VNcZiq/PvZFr4H81+fWEGoEV2LuVdu0BeuxHrikfsTiUPXtcdS9nxZetDIR+6QliuS85
         6f5TGtxp2NUjhmD0pWp6+AR70nz8CV8Vdg/xL+BCaHObWj3XRFZdjz/c58r9ISQjg5NM
         kOLw==
X-Gm-Message-State: AD7BkJKPGnEsDWWVQr/joT3KdYc9YDLDJn3KIz9xIgp90C2oVNjUxaBzreWtKOtTavJ4YQ==
X-Received: by 10.66.147.103 with SMTP id tj7mr21778482pab.72.1457765955947;
        Fri, 11 Mar 2016 22:59:15 -0800 (PST)
Received: from [192.168.1.10] ([182.69.45.48])
        by smtp.gmail.com with ESMTPSA id v7sm17319938pfi.56.2016.03.11.22.59.14
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Mar 2016 22:59:15 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288727>

Hi everyone!

I am Sidhant Sharma, from Delhi, India. I'm a third year Software Engineering
student at Delhi Technological University. I am looking to contribute to
Git via GSoC 2016. I have also worked on one of the microprojects [1]. I've
been using git for nearly two years now, and continue to be surprised by the
vast number of features this powerful DVCS possesses. I want to contribute to
Git because it has become a daily-use tool for me and it feels exciting to
be a part of the community that makes effective collaborative development
possible.

I would like to work on the project titled 'Git Beginner mode', and have been
reading up the discussions that took place regarding this [2]. The reason I wish
to take this project in particular is that when I initially started out with
Git, and was still discovering how things really worked, I sometimes felt the
need for some sort of safety-latch to keep me from making destructive and/or
irreversible changes. So, this project gives me the opportunity to implement
something on these lines for the future beginners. I believe a lot of discussion
on the idea is due. I'm reading up on the commands that were mentioned on the
project page to better understand what the project entails, and trying to design
a solution for this, without making git harder to use or getting in the user's
learning. I would really appreciate your comments, suggestions and critique on
this.

Thanks and regards,
Sidhant Sharma

[1]: http://thread.gmane.org/gmane.comp.version-control.git/288035
[2]: http://thread.gmane.org/gmane.comp.version-control.git/285893/focus=286613
