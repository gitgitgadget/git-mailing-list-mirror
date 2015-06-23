From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 17:51:15 +0200
Message-ID: <55898073.4010105@alum.mit.edu>
References: <1435020656.28466.8.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 17:52:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7QUV-0004l5-0B
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 17:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933241AbbFWPvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 11:51:52 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58577 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932993AbbFWPvV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 11:51:21 -0400
X-AuditID: 1207440c-f79e16d000002a6e-b8-558980757efa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 56.A8.10862.57089855; Tue, 23 Jun 2015 11:51:17 -0400 (EDT)
Received: from [192.168.69.130] (p4FC972ED.dip0.t-ipconnect.de [79.201.114.237])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5NFpFnS005169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 23 Jun 2015 11:51:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1435020656.28466.8.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqFva0Blq8LzDxmL+phOMFl1Xupkc
	mDwWPL/P7vF5k1wAUxS3TVJiSVlwZnqevl0Cd8azzYoFL7wrfl75yNzA2GDXxcjJISFgIrF7
	22xGCFtM4sK99WxdjFwcQgKXGSVWzT/DAuFcYJI4NekDG0gVr4C2xOMfc1lAbBYBVYnmzw1g
	3WwCuhKLepqZuhg5OEQFgiRev8yFKBeUODnzCVi5iECMxK0928FsYQE9iYfn17OD2EIC5hIP
	f7wFi3MKWEjseN0HZjMLqEv8mXeJGcKWl2jeOpt5AiP/LCRjZyEpm4WkbAEj8ypGucSc0lzd
	3MTMnOLUZN3i5MS8vNQiXUO93MwSvdSU0k2MkHDk2cH4bZ3MIUYBDkYlHt4TUztChVgTy4or
	cw8xSnIwKYny6td0hgrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4bVIBcrxpiRWVqUW5cOkpDlY
	lMR5VZeo+wkJpCeWpGanphakFsFkZTg4lCR4r9YDNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfm
	paQWJZaWZMSD4jG+GBiRICkeoL1fQNp5iwsSc4GiEK2nGBWlxHlzQBICIImM0jy4sbAk84pR
	HOhLYd4rIFU8wAQF1/0KaDATyODcNpDBJYkIKakGRr1faT9W7ttSUdP17umXGxxFjVpi2q5X
	Z+1/yyTwI8X62++t14KfuCxt28WzIirb+6Va2L3YEr78rLwu5gSlhhkzow3/uLqtXNuy/OMK
	Z/kl/14/8OBc/8Thf9nh/wILXzotET/s32B+525DlMz7Awxm0Xf6WFmZBB/Mfntv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272458>

On 06/23/2015 02:50 AM, David Turner wrote:
> I've revived and modified Ronnie Sahlberg's work on the refs db
> backend.  
> 
> The work is on top of be3c13e5564, Junio's "First batch for 2.5 cycle".
> I recognize that there have been changes to the refs code since then,
> and that there are some further changes in-flight from e.g. Michael
> Haggerty.  If there is interest in this, I can rebase once Michael's
> changes land.

It's awesome that you are working on this!

I'm reading through your commits and will add comments as they pop into
my head...

* I initially read "refs-be-files" to be a short version of "references,
they be files". I might never be able to get that pronunciation out of
my head :-)

* It would be more modest to call the files implementing the LMDB
backend "refs-be-lmdb.[c,h]" rather than "refs-be-db.[c,h]".

* I wonder whether `refname_is_safe()` might eventually have to become
backend-specific. For example, maybe one backend will have to impose a
limit of 128 characters or something? No matter, though...it can be
moved later.

* You have put `format_reflog_msg()` in the public interface. It
probably makes sense, because more than one backend might want to use
it. But another backend might want to store (refname, old_sha1,
new_sha1, ...) as separate columns in a database. As long as
`format_reflog_msg()` is seen as a helper function and is not called by
any of the shared code, it shouldn't be a problem.

* I wonder whether `init_backend()` will be general enough. I'm thinking
by analogy with object constructors, which usually need class-specific
arguments during their initialization even though afterwards objects of
different classes can be used interchangeably. So I guess the idea is
that a typical `init_backend()` function will have to dig around itself
to find whatever additional information that it needs (e.g., from the
git configuration or the filesystem or whatever). So I think this is OK.

* Your "methods for bulk updates" are I think analogous to the
`initial_ref_transaction_commit()` function that I recently submitted
[1]. Either way, the goal is to abstract away the fact that the
file-based backend uses packed and loose references with tradeoffs that
callers currently have to know about.

* I don't like the fact that you have replaced `struct ref_transaction
*` with `void *` in the public interface. On a practical level, I like
the bit of type-safety that comes with the more specific declaration.
But on a more abstract level, I think that the concept of a transaction
could be useful across backends, for example in utility functions that
verify that a proposed set of updates are internally consistent. I would
rather see either

  * backends "extend" a basic `struct ref_transaction` to suit their
needs, and upcast/downcast pointers at the module boundary, or

  * `struct ref_transaction` itself gets a `void *` member that backends
can use for whatever purposes they want.

* Regarding MERGE_HEAD: you take the point of view that it must continue
to be stored as a file. And yet it must also behave somewhat like a
reference; for example, `git rev-parse MERGE_HEAD` works today.
MERGE_HEAD is also used for reachability, right?

Another point of view is that MERGE_HEAD is a plain old boring
reference, but there is some other metadata related to it that the refs
backend has to store. The file-based backend would have special-case
code to read the additional data from the tail of the loose refs file
(and be sure to write the metadata when writing the reference), but
other backends could store the reference with the rest but do their own
thing with the metadata. So I guess I'm wondering whether the refs API
needs a MERGE_HEAD-specific way to read and write MERGE_HEAD along with
its metadata.

* Don't the same considerations that apply to MERGE_HEAD also apply to
FETCH_HEAD?

* I'm showing my ignorance of LMDB, but I don't see where the LMDB
backend initializes its database during `git init-db`. Is that what
`init_env()` does? But it looks like `init_env()` is called on every git
invocation (via `git_config_early()`). Puzzled.

* Meanwhile, `create_default_files()` (in `builtin/init-db`) still
creates directories `refs`, `refs/heads`, and `refs/tags`.

* Rehash of the last two points: I expected one backend function that is
used to initialize the refs backend when a new repository is created
(e.g., in `git init`). The file-based backend would use this function to
create the `refs`, `refs/heads`, and `refs/tags` directories. I expected
a second function that is called once every time git runs in an existing
repository (this one might, for example, open a database connection).
And maybe even a third one that closes down the database connection
before git exits. Would you please explain how this actually works?

* `lmdb_init_backend()` leaks `path` if `env` is already set (in which
case it needn't compute `path` in the first place).

* You have the constraint that submodules need to use the same reference
backend as the main repository. But it looks like each submodule has its
own independent database. So why the restriction?

It might be a sign that the design is not optimal if it is only able to
handle one *type* of reference backend in a single run.

In object-oriented language, I would expect a `Refs` object to represent
the reference storage for a single repository or submodule. The VTABLE
for the object would be a `struct ref_be`. But the object should also
have an object pointer that can store per-instance data. I think the
per-instance data is missing in your design.

When I start up, I would instantiate a `Refs` instance for the main
repository, which creates either a `FileRefs` or a `LMDBRefs` instance.
This instance would be used to access the refs for the main repository.
It could be stored in a global variable, similarly to how `ref_cache` is
currently stored. (Indeed, `struct ref_cache` would be subsumed into
`FileRefs`.)

If I want to access references in a submodule, there would again be an
initialization process for that sub-repository, which checks the type of
references backend that the repository uses and instantiates either a
`FileRefs` or a `LMDBRefs` instance to represent *that* repository. The
submodule instances could be stored by submodule name in a lookup table,
like submodule_ref_caches is currently stored. Since it has its own
instance data, the `Refs` instance for a submodule can coexist with the
`Refs` instance for the main repository even if they are of different types.

But even aside from supporting heterogeneous submodules, I think adding
instance data to the design would make it quite a bit more flexible,
because it would also allow reference backends to be composed. For
example, one could implement a reference backend that maps
`refs/remotes/origin` to a namespace in another repository, for a
transparent view of an upstream repo (using alternates to share objects)
that doesn't have to be updated when references are updated in the
origin. Or we could implement loose and packed references as two
separate backends that are layered on each other. Or we could implement
a lightweight "mirror" clone with copy-on-write semantics for
references. We could arrange to store all of the references for a
top-level repo and its submodules in a single database, potentially
allowing atomic upgrades across repositories [2].

* You explain in the docstring to `lmdb_transaction_begin_flags()` that
it is dangerous to call a callback function while a write transaction is
open if the callback function might want to initiate another write
transaction. This would obviously also apply to running hooks. This is a
limitation of LMDB because writers block each other. I can't think of
anyplace that this would be a problem in our codebase. But if it were,
it seems to me that you could take an approach like the file-based
backend, which collects the transaction in a `ref_transaction` data
structure, and executes the entire transaction within a single call to
`ref_transaction_commit()`. This approach would prevent callers outside
of the refs module from ever bumping against this limitation.

So, that was my stream-of-consciousness about your patch series. Overall
I like it very much. I have only skimmed it so far, and hardly read the
last two patches at all, but what I saw all looked good and well-organized.

Please CC me on future versions of this patch series, because it is very
close to my interests. I've put a lot of effort into encapsulating and
abstracting the refs module with the goal of getting to pluggable
reference backends (plus some other stuff), so it's great to see what
you have accomplished!

Let me know if you need any help rebasing your work onto my recent
changes. It would probably work best if you break your patch series into
smaller pieces to make them easier for the mailing list to digest. For
example, the first installment could be the patches that make sense even
independent of the plan to add support for multiple backends: the first
two patches, plus the ones related to CHERRY_PICK_HEAD and its cousins,
the abstraction of the reflog functions, and the `git reflog create` and
`git reflog exists` subcommands.

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/272362
[2] To implement this feature, it might be necessary to make the `Refs`
instance for the main repository responsible for instantiating the
`Refs` instance for submodules.

-- 
Michael Haggerty
mhagger@alum.mit.edu
