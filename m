From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/16] lockfile: add accessor get_lock_file_path()
Date: Tue, 11 Aug 2015 12:36:38 -0700
Message-ID: <xmqqlhdhr515.fsf@gitster.dls.corp.google.com>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
	<88c2d7f6a06d3f56731875036e6ba98e1b74011e.1439198011.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 11 21:36:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPFLp-0005oy-3w
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 21:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbbHKTgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 15:36:41 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36096 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbbHKTgk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 15:36:40 -0400
Received: by pdco4 with SMTP id o4so86944481pdc.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 12:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/c/7j3BdTAj8C1hdsBuuGkSDXipqhzMCu1M3X0ERKO4=;
        b=Dg4OpKqFlNjGU3OoUAvRyy5wtZX+KKDgj8BJXaNAJ5dKF8NPbHJ1SA+FzCn39U6t75
         AR4lu+Fwt9zpCeF5lvW6H21XvcpRXFa0vj9nW++kwid0H4xMi0LEF1yKTkjSzJPuREan
         QeQEWjkLjZMNCkSqZBitCzGQD2rojzgQ2SAOo2NgEasvE2gk+MQddUohTz7GpWC3kHu7
         bpShiu0BRZgIMQ2fuCIQzM0kRtVmCRzzr3lQMiSHMM9ZMUvTU1wvTOhswvb+vAg1yAzf
         EkgUtXLC03jAUAyouzowDLhxon+deJ+8ADP0QBrcSUks5w2xAIh/gG7Gkxl1h+Oik6km
         WOkg==
X-Received: by 10.70.101.200 with SMTP id fi8mr13043948pdb.139.1439321799867;
        Tue, 11 Aug 2015 12:36:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id p1sm3651272pdb.3.2015.08.11.12.36.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 12:36:39 -0700 (PDT)
In-Reply-To: <88c2d7f6a06d3f56731875036e6ba98e1b74011e.1439198011.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 10 Aug 2015 11:47:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275714>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

I was briefly confused by the similarity between get_locked_file_path()
and this new helper ;-) but names of both make sense to me.
