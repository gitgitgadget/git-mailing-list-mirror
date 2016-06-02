From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git gc and worktrees
Date: Thu, 2 Jun 2016 06:08:06 +0200
Message-ID: <574FB126.4090805@alum.mit.edu>
References: <574D382A.8030809@kdbg.org>
 <CACsJy8BHU0YtgvjuefRPuMPLhvoOPLVMhR4YzH8=wVFeOie+Xw@mail.gmail.com>
 <20160531221415.GA3824@sigill.intra.peff.net> <574EA364.60408@alum.mit.edu>
 <xmqqbn3l0wkv.fsf@gitster.mtv.corp.google.com>
 <574F0983.5030108@alum.mit.edu>
 <xmqqmvn4y9zq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 06:08:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Jvh-0007Q7-4w
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 06:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbcFBEIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 00:08:12 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:60074 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750740AbcFBEIL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 00:08:11 -0400
X-AuditID: 12074414-63fff700000008e6-e5-574fb12ab825
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 26.E2.02278.A21BF475; Thu,  2 Jun 2016 00:08:10 -0400 (EDT)
Received: from [192.168.69.130] (p508EAEB0.dip0.t-ipconnect.de [80.142.174.176])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u524871B009770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 2 Jun 2016 00:08:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqqmvn4y9zq.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqKu10T/coPuTssX8TScYLbqudDNZ
	NPReYbZ4Mvcus0X3lLeMFj9aepgd2Dx2zrrL7vHwVRe7x7PePYweFy8peyx4fp/d4/MmuQC2
	KG6bpMSSsuDM9Dx9uwTujHc981gL7mpVPJvWxdrA2K3YxcjJISFgIvF31QxmEFtIYCujxLX+
	wC5GLiD7PJNE19MfjCAJYQFFiWlLL7GC2CICahIT2w6xQBQdYJL403KIGcRhFtjHKNF0uIcJ
	pIpNQFdiUU8zmM0roC2xYWkL2AoWARWJQ7+fgk0VFQiROL9uKytEjaDEyZlPWEBsTgFriTOP
	f7GB2MwCehI7rv9ihbDlJba/ncM8gZF/FpKWWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4
	OTEvL7VI10IvN7NELzWldBMjJMRFdjAeOSl3iFGAg1GJh5dBxz9ciDWxrLgy9xCjJAeTkijv
	yjKgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeTyuAcrwpiZVVqUX5MClpDhYlcd5vi9X9hATS
	E0tSs1NTC1KLYLIyHBxKEryiG4AaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kFR
	GV8MjEuQFA/Q3uvrQfYWFyTmAkUhWk8x6nIc2X9vLZMQS15+XqqUOO9bkCIBkKKM0jy4FbCE
	9opRHOhjYV5BkEt4gMkQbtIroCVMQEviM3xAlpQkIqSkGhhLp6hoyj09fFg32vrkys+OypIX
	OjbOeMuuWsQ2zeJF6XYjrSTXFa9efYrm3rdMZtZGG6+oOsOZBtxFsmnJgq1qkYum 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296186>

On 06/01/2016 09:39 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I argue that the fundamental concept in terms of the implementation
>> should be the individual physical reference stores, and these should be
>> compounded together to form the logical reference collections and the
>> sets of reachability roots that are interesting at the UI level.
> 
> That is very good in principle.  How does that principle translate
> to the current setup (with possible enhancement with pluggable ref
> backends) and multiple worktrees?  Let me try thinking it through
> aloud.
> 
>  * Without pluggable ref backend or worktrees, we start from two
>    "physical reference stores"; packed-refs file lists refs that
>    will be covered (overridden) by loose refs in .git/refs/.
>    Symbolic refs always being in loose falls out as a natural
>    consequence that packed-refs file does not record symrefs.
> 
>  * Throw in multiple worktrees to the mix.  How?  Do we consider
>    selected refs/ hierarchies (like refs/bisect/*) as separate
>    physical store (even though it might be backed by the files in
>    the same .git/refs/ filesystem hierarchy) and represent the
>    "logical" view as an overlay across the traditional two types of
>    physical reference stores?  That is:
> 
>    - loose refs in .git/HEAD, .git/refs/{bisect,...} for
>      per-worktree part form one physical store.  If a ref is found
>      here, that is what we use as a part of the logical view.
> 
>    - loose refs in .git/refs/{branches,tags,notes,...} for common
>      part form one physical store.  For a ref that is not found
>      above but is found here becomes a part of the logical view.
> 
>    - packed refs in .git/packed-refs is another physical store.  For
>      a ref that is not found in the above two but is found here
>      becomes a part of the logical view.

I think I would represent the logical store of a worktree repo as
follows. First, I would implement a cached_ref_store that introduces a
layer of caching around another ref_store. Then

    def get_files_ref_store(dir) {
        loose = create_cached_ref_store(get_loose_ref_store(dir))
        packed = create_cached_ref_store(get_packed_ref_store(dir))
        return create_files_ref_store(loose, packed)
    }

    common_ref_store = get_files_ref_store(common_dir)

    /*
     * I think we only allow loose refs in worktrees; otherwise
     * this could be an overlay_ref_store too. Actually, we might
     * want to omit the caching here.
     */
    local_ref_store = create_cached_ref_store(
            get_loose_ref_store(git_dir))

    logical_ref_store = create_worktree_ref_store(
        local_ref_store, common_ref_store)

Where worktree_ref_store does something like

    if (is_per_worktree_ref(refname))
        lookup in local_ref_store
    else
        lookup in common_ref_store

for reading, and uses a merge_ref_iterator with a select function that
does something similar for iterating.

The files_ref_store would do lookups by looking first in the
loose_ref_store then in the packed_ref_store, would use an
overlay_ref_iterator for iteration, and would know to do all writes in
the loose_ref_store (except for deletes, which also have to go to
packed_ref_store). It would have a special "pack-refs" operation,
specific to files_ref_store, that shuffles references between its two
backends.

Writing to a worktree_ref_store is a bit tricker, because we want to
allow ref_transactions to span worktree and common refs (though we
probably need to give up atomicity for any such transaction). The
worktree_ref_transaction_commit() method has to split the main
transaction into two sub-transactions, one for each of its component
ref_stores. I planned for this when designing split_under_lock and think
it is possible, though I admit I haven't implemented it yet.

One nice thing about this design is that you can skip the
worktree_ref_store layer and its overhead entirely for repositories that
are not linked. The decision can be made once, at instantiation time,
rather than every time a reference is looked up. See the pseudocode below.

> Up to this point, I am all for your "separate physical stores are
> composited to give a logical view".  I can see how multi-worktree
> world view fits within that framework.
> 
>  * With pluggable ref backend, we may gain yet another "physical
>    reference store" possibility, e.g. one backed by lmdb.  If it
>    supports symrefs, a repoitory may use lmdb backed reference store
>    without the traditional two.
> 
>    But it is unclear how it would interact with the multi-worktree
>    world order.

Since you could plug-and-play different ref_stores in the above scheme,
I don't see any problem here.

    def get_logical_ref_store() {
        local_ref_store = get_local_ref_store(git_dir)
        if (is_linked_repo) {
            common_ref_store = get_ref_store(common_dir)
            return worktree_ref_store(local_ref_store,
                                      common_ref_store)
        } else {
            return local_ref_store;
        }
    }

get_ref_store() would read the git config to decide what the ref store
to use for the specified repository, which itself might be an
lmdb_ref_store or an overlay_ref_store(loose_ref_store, packed_ref_store).

Michael
