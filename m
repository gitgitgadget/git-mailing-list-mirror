From: Vicent Marti <vicent@github.com>
Subject: [ANNOUNCE] libgit2 v0.13.0
Date: Sun, 19 Jun 2011 13:06:42 +0200
Message-ID: <BANLkTimVueq0UMc6WX0AB64Of=aOBHCLLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git-dev@github.com
To: libgit2@librelist.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 13:07:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYFqb-00037e-2G
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 13:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448Ab1FSLHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 07:07:05 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41246 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423Ab1FSLHE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 07:07:04 -0400
Received: by wyb38 with SMTP id 38so1104437wyb.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 04:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=OAs8+lD9gAGKgLpsr4Me7oPhMbsPOPq9JTopsrMmILs=;
        b=hiY4X5xag1GavR2WyOcwRPJAhqQPpum3elb+DeoOmnyl8Jq7n/wwstlrDpHcnDFBNl
         4DHPcpSelCC0viwMR0fcpNokooEPpHDg6nqRkaV37MtXq4eywLcrhNecSPctj7PNFqzC
         4NUgOwS+TWU82So24JaODOj6tr9zEa6wJvpcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        b=Vi/+6/HaBKVaSXbFu75gXQKCN4O7Vgg3EkLxJ43cQF0SWc9PQJNGG7s7Vmccpp6SVk
         1be9Cv5MQN+zNnkkPwBfX20lXG8gDkio5raM0JlXxQJhwlVtXFwAokdBotsRLcuNh7Mu
         kNjCqdZIoi8JWRGzPn3rXu+MuLaar8wLhGKDo=
Received: by 10.227.196.208 with SMTP id eh16mr3873410wbb.37.1308481622306;
 Sun, 19 Jun 2011 04:07:02 -0700 (PDT)
Received: by 10.227.142.11 with HTTP; Sun, 19 Jun 2011 04:06:42 -0700 (PDT)
X-Google-Sender-Auth: kI1ZbQjvyuJ4vMuL7gFOhSKU0Ys
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176000>

Hello everyone,

one more month, and another minor release of libgit2. We're getting there.

The release has been tagged at:

   https://github.com/libgit2/libgit2/tree/v0.13.0

A dist package can be found at:

   https://github.com/downloads/libgit2/libgit2/libgit2-0.13.0.tar.gz

Updated documentation can be found at:

    http://libgit2.github.com/libgit2/

The full change log follows after the message.

Thanks for your time,
Vicent

=========================

libgit2 v0.13.0 "Watermelon Wheat"

On this rascalicious minor release of libgit2:

- We've dropped support for Waf. All the build process is now managed
through CMake for all platforms.

- We've removed the custom backends from the repository. You can now
find a collection of Custom backends on their own repo, under the
libgit2 org. Including MySQL and Memcache backends, courtesy of the
beardful Brian Lopez.

- We are rocking a new documentation system, Docurium, courtesy of the
insightful Scott Chacon. Check out the details for each single method
in our external API and the way they've evolved through the history
of the library:

	http://libgit2.github.com/libgit2/

This will certainly come in handy if you are developing bindings for
the library.

- You can now check the linked version of the library from your
application or bindings, using `git_libgit2_version`.

- We have a gazillion new features, courtesy of our invaluable
collaborators, including:

	* Support for Config files!
	* Support for prefix-only reads on the ODB
	* Repository discovery
	* Support for the Unmerged Entries index extension
	* Better Windows support
	* 30.000 bug fixes (actual number may be lower)

Thanks as always to everyone who makes this project possible.

Here's the full list of all external API changes:

- git_index_open_bare
- git_index_open_inrepo
- git_odb_backend_sqlite
- git_oid_mkraw
- git_oid_mkstr
- git_reference_listcb
- git_repository_workdir

= git_index_get
= git_repository_path
= git_tree_entry_byindex

+ git_blob_lookup_prefix
+ git_commit_lookup_prefix
+ git_config_add_file
+ git_config_add_file_ondisk
+ git_config_file__ondisk
+ git_config_find_global
+ git_config_foreach
+ git_config_free
+ git_config_get_bool
+ git_config_get_int
+ git_config_get_long
+ git_config_get_string
+ git_config_new
+ git_config_open_global
+ git_config_open_ondisk
+ git_config_set_bool
+ git_config_set_int
+ git_config_set_long
+ git_config_set_string
+ git_index_entry_stage
+ git_index_entrycount_unmerged
+ git_index_get_unmerged_byindex
+ git_index_get_unmerged_bypath
+ git_index_open
+ git_object_lookup_prefix
+ git_odb_read_prefix
+ git_oid_fromraw
+ git_oid_fromstr
+ git_oid_ncmp
+ git_reference_foreach
+ git_repository_config
+ git_repository_discover
+ git_repository_is_bare
+ git_tag_lookup_prefix
+ git_tree_entry_type
+ git_tree_lookup_prefix
