From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 04/10] unpack-trees: fix sparse checkout's "unable to
 match directories" fault
Date: Tue, 16 Nov 2010 09:43:57 +0700
Message-ID: <AANLkTimozeFehA2SHcwsPYxs-Q2k_DFa2DE-i_m--Zq8@mail.gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-5-git-send-email-pclouds@gmail.com> <20101115191041.GE16385@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 03:45:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIBXf-0006ID-WD
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 03:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759200Ab0KPCpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 21:45:01 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:56483 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab0KPCpB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 21:45:01 -0500
Received: by wwb13 with SMTP id 13so39249wwb.1
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 18:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=1FOr/VjPuxHObxRbmwYiVfiqQZk8q8NuY2BCEbDmTfw=;
        b=BUTJak1IbDZ5bt3O/LrX0bh6YeqVD2O2iganjO4QCkwUyb5e5RioEJ54QjqRozvGjF
         1DuvO3+HEouESGza6gTbwhEkja28mkP6e5NE5XUumvDDwn3h0zkRMjKUktdReHZOLRuR
         B6UIYghy4EiYSQ3p84RBBOliqpz40jvbG4ETg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=v3kFMENEHiGPlZU/0NPCHhqSvxkKKCa9ZkJUrRZHR9j47ddhKvVPioVS7v5hIEF9Lg
         W//U+qEBqrG4+PrlUaPfoXIaS/I4stH5rcqODMOowZI2VYQMnrgTqVXZ7oNVVdACvP61
         K7PKMkc4uhrd8xGvYwvkSODLBxchvNgnP1KQE=
Received: by 10.216.172.9 with SMTP id s9mr6000575wel.56.1289875457339; Mon,
 15 Nov 2010 18:44:17 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Mon, 15 Nov 2010 18:43:57 -0800 (PST)
In-Reply-To: <20101115191041.GE16385@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161533>

2010/11/16 Jonathan Nieder <jrnieder@gmail.com>:
> Is it possible to make the two code paths share code without
> sacrificing speed?

I think so. I'll merge the two functions in set_new_skip_worktree() as
you suggested in the previous mail.
-- 
Duy
