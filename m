From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Fri, 04 May 2012 11:10:19 -0700
Message-ID: <4FA41B8B.8070000@palm.com>
References: <4F9F128C.5020304@palm.com>  <201204302331.q3UNVo7o032303@no.baka.org> <4F9F28F5.2020403@palm.com>  <201205010137.q411bxaU002449@no.baka.org> <4F9F52B9.9060508@palm.com>  <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>  <4FA2D8EA.7030809@palm.com> <87obq5ggpu.fsf@an-dro.info.enstb.org>  <7vehr1dl2z.fsf@alter.siamese.dyndns.org> <4FA307C5.102@palm.com>  <4FA3090D.5080406@palm.com> <4FA32A6A.4070007@blizzard.com>  <CA+7g9Jxp859st6SrViizwOMrU9vsnmfy6P64SK9y_-ZEzEB6Mw@mail.gmail.com>  <1167779eee7d442b9db0eecb347d5516-mfwitten@gmail.com>  <7vmx5ocyc3.fsf@alter.siamese.dyndns.org> <1336126182.3490.28.camel@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Witten <mfwitten@gmail.com>,
	Nathan Gray <n8gray@n8gray.org>,
	Illia Bobyr <ibobyr@blizzard.com>,
	Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri May 04 20:10:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQMxV-0008JT-Tp
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 20:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025Ab2EDSKV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 14:10:21 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:57168 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab2EDSKU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 14:10:20 -0400
X-IronPort-AV: E=Sophos;i="4.75,532,1330934400"; 
   d="scan'208";a="13316280"
Received: from unknown (HELO ushqusdns4.palm.com) ([148.92.223.164])
  by smtp-relay2.palm.com with ESMTP; 04 May 2012 11:10:20 -0700
Received: from fuji.noir.com ([10.100.2.1])
	by ushqusdns4.palm.com (8.14.4/8.14.4) with ESMTP id q44IAJp0007635;
	Fri, 4 May 2012 11:10:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1336126182.3490.28.camel@beez.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197043>

On 5/4/12 03:09 , Carlos Mart=C3=ADn Nieto wrote:
>      To $uri_for_central_repo
>      ! [rejected]        HEAD ->  feature_0 (non-fast-forward)
>
>      error: failed to push some refs to '$uri_for_central_repo'
>
>      Some updates which might rewrite history and lose someone else's
>      changes were rejected. Merge those changes (e.g. 'git pull') to
>      incorporate that history. See the 'Note about fast-forwards' sec=
tion
>      of 'git push --help' for details.

I'd like to suggest "declined" instead of "failed".  "error: failed"=20
suggests an error in the data or in the tool rather than a default or a=
=20
choice on the part of a UI designer.

The first few times I got this error I presumed that it was telling me=20
my destination repository was corrupt.  So I salvaged my changes with=20
diff and patch, trashed the repository, and cloned a fresh one, (which=20
didn't show this error when I pushed to it.)

--rich
