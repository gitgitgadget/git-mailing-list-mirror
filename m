From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [GSOC Update] Week 2
Date: Sun, 15 May 2016 23:15:59 +0530
Message-ID: <1463334359-14033-1-git-send-email-pranit.bauva@gmail.com>
References: <1462706822-5189-1-git-send-email-pranit.bauva@gmail.com>
Cc: christian.couder@gmail.com, chriscool@tuxfamily.org,
	larsxschneider@gmail.com, andrew.ardill@gmail.com,
	Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 19:49:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b20A2-0007cm-FY
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 19:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbcEORs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 13:48:58 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33947 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbcEORs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 13:48:57 -0400
Received: by mail-pf0-f193.google.com with SMTP id 145so13705737pfz.1
        for <git@vger.kernel.org>; Sun, 15 May 2016 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u281UskwZAOhSGfFdWBDBi/tpgQx7yFW1KVGlsmVdFE=;
        b=W6LoKgfb71PLncs3yMXZ9CMlf5i3NOgsSufqiLrL4j6lImcd5maSMBRdixnoX4K62z
         inaNh9i0WZp3z6E9fZ6JlmaNFAqXfHlVL9Y9btC3xnRTM7MPAlNXMRTAc8U8rfkqKxN/
         hVgay6ryUEQxJ5xoJttvJ6UJX6mlQOfr+HHmKTdpBX4b6FjS2t+Z4I0whpBXebLvE7VY
         Akb9abEHGzhINUIbXGqzoNtbrTBDgJAqEDTYG1+62K+PxJKQ1HYzcAdBTiQ2V/QTVYq1
         +cJVjQYXW70z82sWZuGLUalux38suuCsWT4SCcB4ZLyNe1M4cTvzosUflWtic3S+jXGs
         ejOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u281UskwZAOhSGfFdWBDBi/tpgQx7yFW1KVGlsmVdFE=;
        b=KBIr6Cev0yl/FVhpeir9UnvOFU1UA8Iv71HscmJTHv3VJkv8dZwyCFM9l4zOLBu2of
         YDJTS0rhzwwqQc/S3/S27PQnY46A+khUWCfHhBPYYdRqOBFtOMkVRbqL1pJ+nCq5BAOb
         3icn1x9k622lifnCthx3ByADzyzPVru7OKT9uffSnCqrk5zaUppp795SX2yrtHI9wYUA
         Rl1UZ6jSgkzevfwQQHyc95rtRHIP1cFvx7e3N+lI/qVjZTHGtI2c8jUJWWB+yhiVVr9B
         iKhJgPTvkukxtyO4vOgsOOHqSKJNSc4HT3feU6p7Zhciopg7BOqSEgBSsu4kSY0pNGbv
         wCVg==
X-Gm-Message-State: AOPr4FXLl4FnsUFGf6aniU15iLtI01AJkOWV/iS+HhqUApce/mclPH3KmlBVE4uEqhRXVQ==
X-Received: by 10.98.50.67 with SMTP id y64mr39269265pfy.128.1463334536399;
        Sun, 15 May 2016 10:48:56 -0700 (PDT)
Received: from localhost.localdomain ([183.87.140.254])
        by smtp.gmail.com with ESMTPSA id u2sm41707325pan.45.2016.05.15.10.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 May 2016 10:48:55 -0700 (PDT)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1462706822-5189-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294672>

================================= SUMMARY ==================================
My micro project on adding config variable to git-commit for verbose options
is going to be merged with the master branch soon and will be available for
git 2.8.3 . I also rewrote a few shell functions in C.

My public git.git is available here[1]. I regularly keep pushing my work so
anyone interested can track me there. Feel free to participate in the
discussions going on PRs with my mentors. Your comments are valuable.


=============================== INTRODUCTION  ==============================
The purpose of this project is to convert the git-bisect utility which partly
exists in the form of shell scripts to C code so as to make it more portable.
I plan to do this by converting each function to C and then calling it from
git-bisect.sh so as to use the existing test suite to test the function which
is converted.

Mentors:
Christian Couder <chriscool@tuxfamily.org>
Lars Schneider <larsxschneider@gmail.com>


================================== Updates =================================
Things which were done in this week:

 * I have sent the patches[2] for check_term_format() and write_terms() so
   as to demonstrate how I am going to use the subcommand approach wherein
   I will first convert a method and then call it by using a subcommand.
   Then when another method is converted the previous method will be removed
   from the subcommand and will instead be called from the new method. Junio
   has collected this patch and queued it on a branch gitster/pb/bisect and
   is available for testing on the pu branch. I am encouraging people to
   test it and provide useful comments.

 * I have also converted bisect_log() and bisect_voc() whose patches[3] are
   sent to the list. Junio is yet to pick these up.

 * I have converted the function bisect_clean_state() but its in a very
   rudimentary form. Well I generally do like this. I first have a *just*
   working model of a function and then I polish it by introducing the git's
   API and write error handling code and resolve the style issues. Though it
   is available on github[4]. The current version plainly removes the refs
   using the git's API. I am quite aware that refs shouldn't be handled in this way
   (this fact is constantly reminded in the docs). I am reading up on the
   available methods for refs manipulation.

 * I have also sent an independent patch[5] to explicitly test whether
   bisection state is properly cleaned up.

 * Also studied the functioning (upto an extent) of git-for-each-ref and
   git-udpate ref as it is required during the conversion of
   bisect_clean_state().

 * The main part (I think) was that I read about the method's which handled the
   refs. It was an interesting read though I did not read upon the actual
   implementations of those, I mainly covered "What does the method do?" and
   "How to use the method in my code?". git-grep is my best friend for this.

 * I am still quite amazed by the amount of attention refs receive. Christian
   explained a bit though I still don't get the feel why they are *sooo*
   important. I was recently reading the Git Rev News and also seeing the
   patches by Michael Haggerty and David Turner and I was quite amazed on
   the amount of attention refs get.

 * I also noticed a minor thing with bisect cleanups[6]. After the bisection
   state is cleaned up the folder "refs/bisect/" is not removed. I pointed
   this out but Christian thought it is okay the way it is.

 * When I was converting the function write_terms() Christian advised to use
   `|| exit` when calling it with a subcommand using `git bisect--helper
    --write-terms $TERM_BAD bad` but it got the test no. 43 and 44 failing in
    t6030. On a little bit investigation by Christian, these tests seem to
    fail when there is a bare repo. He asked me to investigate it further.
    I have currently not found enough time. Will do it in the coming week.


================================= NEXT STEPS ================================
Things which would be done in the coming week:

 * Finish bisect_clean_state() conversion. I will first put it up on github
   to receive comments from my mentors and then post it to the mailing list.

 * Convert the function bisect_head(). I plan to convert this function and add
   it as a subcommand to test the implementation but I will only send the
   function without the subcommand to the mailing list because its a too small
   function. Though the subcommand version will be put up on github for
   everyone to verify whether it is passing the test suite like I have done it
   for bisect_voc().

 * Convert the function bisect_write(). I plan to convert this function and
   add it as a subcommand.

 * Investigate why test no. 43 and 44 are failing in t6030 with `|| exit` in
   --write-terms.


================================ NOTIFICATION ==============================

I will be taking a short vacation from 16th May, 2016 to 19th May, 2016 so
I wouldn't be available via email and also will not be able to work. I intend
to make up for the lost time by working on weekends.

[1]: https://github.com/pranitbauva1997/git
[2]: http://thread.gmane.org/gmane.comp.version-control.git/294388
[3]: http://thread.gmane.org/gmane.comp.version-control.git/294571
[4]: https://github.com/pranitbauva1997/git/pull/6
[5]: http://thread.gmane.org/gmane.comp.version-control.git/294520
[6]: https://github.com/pranitbauva1997/git/pull/8

PS: Thanks to Andrew Ardill <andrew.ardill@gmail.com> on providing his comments
of how to improve the format of this update email. I have tried to make it
as exhaustive as possible.

Regards,
Pranit Bauva
