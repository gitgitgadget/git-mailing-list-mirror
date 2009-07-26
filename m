From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH v3 5/5] Implement 'git stash save --patch'
Date: Sat, 25 Jul 2009 23:03:12 -0700
Message-ID: <fabb9a1e0907252303y2606d585l41819a74084b58f1@mail.gmail.com>
References: <7vzlat64u1.fsf@alter.siamese.dyndns.org> <cover.1248557241.git.trast@student.ethz.ch> 
	<e5ef2e602347914a7a14d769ca2297223cde8042.1248557241.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jul 26 08:03:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUwpi-0001lt-Nr
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 08:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbZGZGDg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Jul 2009 02:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752453AbZGZGDf
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 02:03:35 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:46514 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbZGZGDf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 02:03:35 -0400
Received: by ewy26 with SMTP id 26so2537400ewy.37
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 23:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6E25CEPm2+X3qJW/G2ys8BYA6RF64lS5aG1P0BdugQA=;
        b=NkayJAj0r5MqnDWMcu2kHHp0mzciwrd0KsN2allQv8RVlll3hJsnWIMDTUlHWYPAHv
         2VI+cqRUgmfh2Nu3RJizDWoe5qSJQcKefLsvfyO06UBpzoMIvsdFAYiqlIHulYsTLrhA
         km2I4W2cGrQS7Apx9kwFluaQyqOgPAH8njZ2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NL8O7sfvBcPdjCLApkhwD4h2rZCyPRiWVPCs/qAuahzXeCrGylUxkaHvuCjeeoVNiY
         c8t42xvNOupyMA1K5StLORppcSYEZE3K2hcb13Un/0czc8HyyUVrJjLqo1/8huTJpo3S
         CnHOOAX/FqSnJ6p/LkU85vzVxxI8QA58af72c=
Received: by 10.216.45.65 with SMTP id o43mr1351532web.4.1248588213077; Sat, 
	25 Jul 2009 23:03:33 -0700 (PDT)
In-Reply-To: <e5ef2e602347914a7a14d769ca2297223cde8042.1248557241.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124104>

Heya,

On Sat, Jul 25, 2009 at 14:29, Thomas Rast<trast@student.ethz.ch> wrote=
:
> This adds a hunk-based mode to git-stash. =A0You can select hunks fro=
m
> the index and the worktree, and git-stash will attempt to build a
> stash that reflects these changes.

Awesome! Does it also remove the stashed hunks from the worktree? From
what I gather from the patch it looks like it, but the commit message
doesn't say.

--=20
Cheers,

Sverre Rabbelier
