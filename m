From: bruce <bruce.e.robertson@intel.com>
Subject: Re: orphan blob or what?
Date: Fri, 09 Nov 2012 11:37:04 -0800
Message-ID: <87625elg9r.fsf@intel.com>
References: <87a9urlj23.fsf@intel.com> <1352423287-ner-8337@calvin>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 20:37:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWuOF-00087c-Pj
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 20:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544Ab2KIThG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 14:37:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:42492 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753278Ab2KIThF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 14:37:05 -0500
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 09 Nov 2012 11:36:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,747,1344236400"; 
   d="scan'208";a="239664440"
Received: from brucer42-desktop.jf.intel.com (HELO brucer42-desktop) ([10.7.197.86])
  by orsmga002.jf.intel.com with ESMTP; 09 Nov 2012 11:37:04 -0800
In-Reply-To: <1352423287-ner-8337@calvin> (Tomas Carnecky's message of "Fri, 9
	Nov 2012 01:08:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209243>

Tomas Carnecky <tomas.carnecky@gmail.com> writes:

Just idiocy on my part. Thanks.

> On Thu, 08 Nov 2012 16:24:36 -0800, bruce <bruce.e.robertson@intel.com> wrote:
>> In today's and older clones of https://github.com/mirrors/linux.git I
>> find this object, 6fa98ea0ae40f9a38256f11e5dc270363f785aee, that I can't
>> figure out how to eliminate^h^h^h^h^h^h^h^h^hget rid of. I don't see it
>> in 'git fsck', 'git gc --aggressive --prune' doesn't seem to prune it,
>> can't see it via 'git log'. And yet
>> 
>> linux/.git/objects/pack$ git verify-pack -v *.idx | grep 6fa98ea0ae40f9a38256f11e5dc270363f785aee
>> 6fa98ea0ae40f9a38256f11e5dc270363f785aee blob   1519697 124840 515299673
>> 8231eaa31ce1107c1463deb6ec33f61618aedbb9 blob   67 63 515424513 1 6fa98ea0ae40f9a38256f11e5dc270363f785aee
>> f21a8c1b9d47736fa4e27def66f04b9fe2b4bc53 blob   90 83 515424576 1 6fa98ea0ae40f9a38256f11e5dc270363f785aee
>
> Commit dee0bb9 (ASoC: Mark WM8962 Additional Control 4 register as volatile,
> 2010-09-29) references this blob.
