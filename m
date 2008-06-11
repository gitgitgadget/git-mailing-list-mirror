From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] git-rebase -i: have an option for amending the commit
 message only.
Date: Wed, 11 Jun 2008 20:36:45 +0200
Message-ID: <48501B3D.3000405@free.fr>
References: <1213196490-7762-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 20:37:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6VCQ-0000dO-MI
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 20:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbYFKSge convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2008 14:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbYFKSge
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 14:36:34 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:51277 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbYFKSge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 14:36:34 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id A297C12B768;
	Wed, 11 Jun 2008 20:36:32 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 502DA12B744;
	Wed, 11 Jun 2008 20:36:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <1213196490-7762-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84634>

Hi,

I like the feature and I have just two comments:

Pierre Habouzit a =E9crit :
>
> +	comment|c)

Is "comment" the right name? I'm not sure, I just ask.

> +		comment_for_reflog comment
> +
> +		mark_action_done
> +		pick_one $sha1 ||
> +			die_with_patch $sha1 "Could not apply $sha1... $rest"
> +		output git commit --no-verify --amend -e -C HEAD

It does not work with an editor that opens in the current terminal
like vi. Just remove "output" should fix the problem, I think.

Olivier.
