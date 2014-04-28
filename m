From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 04:17:24 -0500
Message-ID: <535e1ca4933da_338911e930c4@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
 <535D4085.4040707@game-point.net>
 <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
 <535D6EB1.9080208@game-point.net>
 <535e18cdc7bce_338911e930c72@nysa.notmuch>
 <535E1CAD.1020304@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:28:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WehrB-0005PQ-8p
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 11:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbaD1J2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 05:28:03 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64619 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbaD1J2A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 05:28:00 -0400
Received: by mail-ob0-f174.google.com with SMTP id gq1so6933388obb.5
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 02:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=9wnMJz/mr4xmwl5c2XF00gEkvkSPq3B5VADd3NKVQeo=;
        b=jMrXBsUKu5a6abEudPN+CDYqcfrube5xqgcsLQX+vU5oI9fiASGM66lxZAZwwVc9xF
         hpDX8nVgQzrDQVEhkrn3gP0Ffg7BHmgekDDfz3TDKL4fGBfSzXcatwjqMGtE+zq2c38V
         McdCejfPfTpb9RDWi0FWpTvQcMsZxlSUd5UczJoyvBcYSzhigLUix8LJlme5n57Jq0i+
         imCy/zncHqXIUZY4eEd4crIXyk553hwAEgc75Sv3YYH7rBH0RVK2ZTMQNt7AGrCUzM2/
         zEhw65+EQaS1P95HFGiGMIQsmR3f48geSTN/1R+QZOwYPfClvprDBOE4P7djsi1MlEug
         9RZg==
X-Received: by 10.182.96.168 with SMTP id dt8mr21658343obb.43.1398677279554;
        Mon, 28 Apr 2014 02:27:59 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ut8sm35576052obc.22.2014.04.28.02.27.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 02:27:58 -0700 (PDT)
In-Reply-To: <535E1CAD.1020304@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247262>

Jeremy Morton wrote:
> On 28/04/2014 10:01, Felipe Contreras wrote:
> > Jeremy Morton wrote:
> >> On 27/04/2014 20:33, Johan Herland wrote:
> >>> The problem is not really "less tidy commit trees" - by which I gather
> >>> you mean history graphs that are non-linear. IMHO, the history graph
> >>> should reflect parallel/branched development when that is useful.
> >>> Blindly rebasing everything into a single line is IMHO just as bad as
> >>> doing all your work directly on master and blindly running "git pull"
> >>> between each of your own commits (which results in a lot of useless
> >>> merges). The merge commits themselves are not the problem. Merge
> >>> commits are a tool, and when used properly (to introduce topics to the
> >>> master branch like described above) they are a good tool. When abused
> >>> (like blindly running "git pull" and accepting useless "merge
> >>> bubbles") they create more problems than they solve.
> >>
> >> Sounds like the default behaviour of "git pull" might not be ideal if it
> >> easily causes these problems.
> >
> > It's not idea. Virtually everyone agrees with that, even Linus Torvalds, and we
> > have the patches to fix it, but it's not going to change.
> >
> > The Git project doesn't welcome change.
> 
> Well, you sure don't seem to.  Why are there so many "no-can-do" people 
> on this list?  :-)

I don't seem to what? I'm the one arguing for change, and I sent the patches to
fix this default behavior.

-- 
Felipe Contreras
