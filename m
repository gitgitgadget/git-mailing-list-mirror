From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: mergetool: support --tool-help option like difftool does
Date: Mon, 23 Jul 2012 20:56:26 +0200
Message-ID: <500D9E5A.2000204@gmail.com>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com> <500CFAE1.3070304@gmail.com> <7vr4s2mnir.fsf@alter.siamese.dyndns.org> <7vipdemm0a.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:56:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNo6-0006gZ-Pi
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab2GWS4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:56:33 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34021 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab2GWS4c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:56:32 -0400
Received: by wgbdr13 with SMTP id dr13so6126631wgb.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 11:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=s6i1RKmGnrhbrXExNqjs8XPwITOTucw125sXvZUtMug=;
        b=CCqq3rwE75E2ymadvCrj6JcGJ4FCrUBzkeW3zCCUzebwUJ7LzyGfL4nLc/ymMOnB4R
         gV6KV824h4OJGwSsqyktljhoKfz6xLD0fX4MuJaM7HuVd3eUEJPRv+7MAjy3DbUdIcdm
         f6Fg+jM58uV4Ko6ziOd6Nxv+l9OSBiS9vv+XE1ZGYNriZbb+kXb5ksLX9L+tTCGyeZgI
         Z/yK97prByxcoEgAZadot9rRu9OUpq0xfu9RSUBkAayg1CIrTRKERtAx3Jpq51KVkyK9
         htfIX6x6OWiiwCG0UAKKte0KrSG/1BJrVyv1R5EbtXYu055pC/ZkRlqKu36w/bT+vnCC
         YqjA==
Received: by 10.180.103.4 with SMTP id fs4mr50561wib.16.1343069791005;
        Mon, 23 Jul 2012 11:56:31 -0700 (PDT)
Received: from [192.168.178.22] (p5DDB0653.dip0.t-ipconnect.de. [93.219.6.83])
        by mx.google.com with ESMTPS id de10sm68186wib.7.2012.07.23.11.56.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 11:56:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vipdemm0a.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201961>

On 23.07.2012 19:21, Junio C Hamano wrote:

> This way we do not have to risk the list of tools go out of sync
> between the implementation and the documentation.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks! I've squashed this with

[PATCH v2 5/5] Add a few more code comments and blank lines in guess_merge_tool

and parts of

[PATCH 3/5] Explicitly list all valid diff tools and document --tool-help as an option

and adjusted the docs for git-mergetool accordingly.

-- 
Sebastian Schuberth
