From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/12] [TODO] setup: bring changes from
 4msysgit/next to next
Date: Wed, 02 Jul 2008 23:13:47 -0700
Message-ID: <7v63rn4hr8.fsf@gitster.siamese.dyndns.org>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <alpine.DEB.1.00.0807021716030.9925@racer> <D35A2542-3943-4BDB-AEDA-0F8B7052EF7D@zib.de> <200807022132.27751.johannes.sixt@telecom.at> <B01C53C6-6FB6-44EF-987F-1574A77C2F95@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>,  msysGit <msysgit@googlegroups.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Git Mailing List <git@vger.kernel.org>,  Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: prohaska@zib.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Jul 03 08:15:03 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.244])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEI5t-0006q1-Fu
	for gcvm-msysgit@m.gmane.org; Thu, 03 Jul 2008 08:15:01 +0200
Received: by wa-out-0708.google.com with SMTP id n36so1032326wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 23:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-pobox-relay-id:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=mf3AjGrg18qin14/SHu1ndAxW12nALK0cRytKK8kaf8=;
        b=IGgJ3veZX1Xj28HQhuX4mY3HBdomUJqIn2N45RR2cLHhVfyBwNjACtvQxKIs+ijeu0
         9FCvxNMinLobFoZGwt84n3A93xM6ZdoSJU/54MDmZ05NH2rRvLnhphNESPSSKM9LKz9D
         IDo54qhz2HpxT6CDOfIMWrjNAocah/LAv8Pjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:cc:subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type:x-pobox-relay-id:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=Ckd8lD30By1IPSAmf84U6YcJExOuVppRNoVivuUrOpPTQmebH/vqaPqTqGeRTsH688
         rVgAfi4+qzyAUJ846Ay5zfxBmLAckW0AE3+E6pufkaYRzMbTkyhJ2i2GAz+fQzt8PG0v
         sV3BDZm0cTqDeHhz0HokVFO+Kp4PBfvgvbVVM=
Received: by 10.114.108.15 with SMTP id g15mr625762wac.21.1215065642073;
        Wed, 02 Jul 2008 23:14:02 -0700 (PDT)
Received: by 10.106.193.17 with SMTP id q17gr2589prf.0;
	Wed, 02 Jul 2008 23:14:02 -0700 (PDT)
X-Sender: gitster@pobox.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.66.5 with SMTP id o5mr10217354aga.20.1215065641808; Wed, 02 Jul 2008 23:14:01 -0700 (PDT)
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com [207.106.133.19]) by mx.google.com with ESMTP id 7si9245102yxg.1.2008.07.02.23.14.01; Wed, 02 Jul 2008 23:14:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of gitster@pobox.com designates 207.106.133.19 as permitted sender) client-ip=207.106.133.19;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gitster@pobox.com designates 207.106.133.19 as permitted sender) smtp.mail=gitster@pobox.com
Received: from localhost.localdomain (localhost [127.0.0.1]) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3CEE6C44B; Thu,  3 Jul 2008 02:14:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 65DECC443; Thu,  3 Jul 2008 02:13:54 -0400 (EDT)
In-Reply-To: <B01C53C6-6FB6-44EF-987F-1574A77C2F95@zib.de> (Steffen Prohaska's message of "Thu, 3 Jul 2008 08:06:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3AC07FDC-48C7-11DD-911F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87221>


Steffen Prohaska <prohaska@zib.de> writes:

> On Jul 2, 2008, at 9:32 PM, Johannes Sixt wrote:
>
>> The setup.c in mingw.git (and soon Junio's master) and Junio's next
>> are
>> _different_, but both are correct. If you reverse-apply the patch you
>> presented here, then you get the version from Junio's next, which is
>> a good
>> state.
>
> Ok, I'll wait until Junio's master has the changes and will remove
> the changes to 4msysgit then.

There will be a slight difference between the setup.c in soon-to-be master
and j6t/mingw (14086b0), due to recent optimization already on 'master'
from Linus, 044bbbc (Make git_dir a path relative to work_tree in
setup_work_tree(), 2008-06-19).

diff --git a/setup.c b/setup.c
index 8bb7b10..cc3fb38 100644
--- a/setup.c
+++ b/setup.c
@@ -308,9 +308,10 @@ void setup_work_tree(void)
 	work_tree = get_git_work_tree();
 	git_dir = get_git_dir();
 	if (!is_absolute_path(git_dir))
-		set_git_dir(make_absolute_path(git_dir));
+		git_dir = make_absolute_path(git_dir);
 	if (!work_tree || chdir(work_tree))
 		die("This operation must be run in a work tree");
+	set_git_dir(make_relative_path(git_dir, work_tree));
 	initialized = 1;
 }
 
