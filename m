From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 12:50:57 -0500
Message-ID: <535aa0813e27a_3984aa530c24@nysa.notmuch>
References: <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <20140424195559.GA1336@luc-arch>
 <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
 <5359c9d612298_771c15f72f02a@nysa.notmuch>
 <CAGK7Mr6dss7BF-srQ3SqeZe2hAe9nS07fGe--ka1rvC5hXvbSA@mail.gmail.com>
 <20140425133520.GC11124@thunk.org>
 <CAGK7Mr4g3j80R4P_wpfNip9vxvaDg4q_3Utq9KVvKtbdhVutfQ@mail.gmail.com>
 <20140425144054.GA6230@thunk.org>
 <CAGK7Mr74TK4x7WYnmWyRUj_Aga0CHbyFNyZGZdu6eubtwahBXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 25 20:02:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdkRs-0004PS-Ub
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbaDYSB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:01:26 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:37954 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaDYSBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:01:25 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so4626709obc.34
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=51tHJUdIIgQo3xgSK29hc2YC/BcR4WkhVynTfqpC6rY=;
        b=hHwAlSblBjj6oxY81ZRJ62gqKdns5j4PVv+nimjkPUlZuuJtAdvtjfsJUPTl1esSss
         4GHOo1UWHpU0PRL4Ge90Tv1kuvkuVOCZVqUvj/q+d/Xf1ZyhNck7WtJbrXD2m7bUu5LU
         KvrRdXlpGep602yzfMQdHwsYOZl0nV3UeQhPCl4y5qPWIPdbb3PPpz3eua3tleZX1tLg
         2jhKWBxVTRvKkhcL8Dt1drFC8HuZe7x+p8KW53Ql98eg+Qm86ErvxRnNRxXRQDMQ4h0A
         PiAvsQnwhVKN3CZ01+LDuGaZTRUaZ7apG9hrmLXl1SLXM8ST59DAVuiVNfqzEx/2nK5d
         +Oaw==
X-Received: by 10.182.104.71 with SMTP id gc7mr8031664obb.34.1398448884873;
        Fri, 25 Apr 2014 11:01:24 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cq1sm34518673oeb.4.2014.04.25.11.01.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:01:23 -0700 (PDT)
In-Reply-To: <CAGK7Mr74TK4x7WYnmWyRUj_Aga0CHbyFNyZGZdu6eubtwahBXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247073>

Philippe Vaucher wrote:
> >> Yes, of course there should be a list of both positive and negative
> >> tradeoffs. But I think the "overloaded" argument can be easily solved
> >> by renaming one of the overloads.
> >
> > And renaming one of a term also has costs, especially if it is one
> > that is in use in large amounts of documentation, both in the git man
> > pages, and in web pages across the web.
> 
> It's just impossible to change terms and have previous documentation
> still be valid. Sure, you can list it in the "cons" section as an
> argument, but it's not very convincing in itself because it applies to
> pretty much any interface changes. I think the main idea is to
> _improve_ the interface, which means rename things so it is more
> consistent and so concepts are easier for new comers to grasp. We
> could still support old terms for a while and eventually deprecate
> them.

And that's exactly what I did in my patch series: start introducing the --stage
options along the current ones.

http://thread.gmane.org/gmane.comp.version-control.git/236127/focus=236128

-- 
Felipe Contreras
