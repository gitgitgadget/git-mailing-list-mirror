From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 15:46:41 -0500
Message-ID: <20120416204641.GH12613@burratino>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
 <20120415213718.GB5813@burratino>
 <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
 <7vaa2by8nj.fsf@alter.siamese.dyndns.org>
 <20120416160729.GM5813@burratino>
 <CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
 <20120416200941.GD12613@burratino>
 <CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
 <20120416203320.GF12613@burratino>
 <CAMP44s0Q2A_oKJx27ct9W__KVQkQxzst3H7gq6sZDhrCLDQaag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:47:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJspB-00065Z-7M
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 22:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643Ab2DPUq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 16:46:56 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44927 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab2DPUqz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 16:46:55 -0400
Received: by obbta14 with SMTP id ta14so4110776obb.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 13:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3JCG5PXdPlkLvZ4vh4KBZbftFrxUaAs3rFlmBjlji9I=;
        b=XP+kGlMAtEQlxZtl3DIL2qB8gzu/ym7sL635JDtZvKEMZC+rVjnwsCYx8rvqa5v1uo
         7D6pT0bmSiSwwGYQfyCzS78VWwHdlQN1InoawaScooGwfSmzDBaPNZLDEOGEzLYcSVnf
         90O/wS2BJQx3P96zEr0YwPHRbU+fEpwgO6JSiOmb6/jQmQM6xuaRvUu6XpOhQx8Iyg51
         TsYPSXVnxb6cNq7H3pz8Kzc7tb+Y0dFB+zfs61xnlojH3GcZVvSJS1K1QmYN8xNT+1Lx
         ddOLJysfD7ja2kshnQMs07+fR6QO9BzevO8r3Mt0JSH+Fk8xT/XWXGvlZiQyp9vo1Bfk
         xZpg==
Received: by 10.182.72.38 with SMTP id a6mr1053394obv.38.1334609214984;
        Mon, 16 Apr 2012 13:46:54 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n9sm16569565oen.2.2012.04.16.13.46.53
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 13:46:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s0Q2A_oKJx27ct9W__KVQkQxzst3H7gq6sZDhrCLDQaag@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195691>

Felipe Contreras wrote:

> Now, even if you use the bash completion library, it still does export
> functions without a prefix

Are you sure?  "complete" is a bash builtin and has nothing to do with
the bash completion library except that the latter uses it.
