From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] stage: add edit command
Date: Thu, 29 Aug 2013 13:42:12 -0500
Message-ID: <521f960477ebf_16921225e74769a3@nysa.mail>
References: <20130829180129.GA4880@nysa>
 <1377799744-5201-1-git-send-email-felipe.contreras@gmail.com>
 <1377799744-5201-3-git-send-email-felipe.contreras@gmail.com>
 <vpqk3j4s5ut.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:49:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7Hl-0000aH-Jl
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875Ab3H2Stc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:49:32 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:45198 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070Ab3H2Stb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:49:31 -0400
Received: by mail-oa0-f43.google.com with SMTP id i10so1110817oag.2
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Hmg3F9x4hHOXeNxOpSFFTKuHrecB3MfSuD3IQjTXT3U=;
        b=0sriUHZYRdQWs7jrUIS+gy7hsJ14m/dB6wuZmtID8hc7I83eNU15anVWNKWrhW5q2b
         ecjHGHvpf8Ms0HtHGjjc4YWVK2NXeIr8th8SdsZcRzFPB0Upxo8R8W8lhlqHJaMfwuew
         1zQjo9baLjxnBVqMxbuXDo1P1AONt3OuYHCAHF/rlsfLrBAzUjiSpsnSxQZ5pU+ev7aO
         iuV4qXO9hWHk1HhGqO9FExe+NB7NMyBWGyHoDUseFfr9XcK/o/8qtNiqJiUe2lB+wGuQ
         zFYb2g96VnmnHTo6LJWP/0FUnHiFkzf1ewwGHcTdaXDL3hcbxUu5eM6BUetTLphORxcM
         OsjQ==
X-Received: by 10.182.186.97 with SMTP id fj1mr3136515obc.53.1377802171177;
        Thu, 29 Aug 2013 11:49:31 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id nw5sm4697404obc.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:49:29 -0700 (PDT)
In-Reply-To: <vpqk3j4s5ut.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233334>

Matthieu Moy wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > +'edit'::
> > +
> > +Manually edit the staging area (as a diff).
> > +
> 
> That sounds interesting. It reminds me "git add --edit", but they are
> different ('stage edit' edits the patch with HEAD, 'add --edit' edits
> the patch with the worktree).

That's not the only difference; 'add --edit' is incremental.

> Can we find a consistent user-interface where "git add --edit" and "git
> stage edit" have a closer syntax? Maybe "git stage edit --work" as a
> synonym for "git add --edit"?

Well, the action is adding changes to the staging area. To me, I'm not editing
the stage, I'm editing the change I'm adding to the stage, so 'git stage
--edit' is perfectly fine.

-- 
Felipe Contreras
