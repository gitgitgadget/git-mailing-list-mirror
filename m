Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8900F1F51C
	for <e@80x24.org>; Sat, 19 May 2018 12:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeESMqr (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 08:46:47 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41878 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbeESMqp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 08:46:45 -0400
Received: by mail-oi0-f65.google.com with SMTP id 11-v6so9431777ois.8
        for <git@vger.kernel.org>; Sat, 19 May 2018 05:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=LbMnIR0spr5diHeTXRfbyDPzHDIIQJ53o20LE3YI57Y=;
        b=QjhyFLPEp8IswENx3vipY68fJ+zXs+GhbOLUdoBFIq8oOAY42Y6d3EDnSlt8Ardr3o
         nS6vMfDH6ImQJeOWxJK97EXuwZgsfBPxAjAr5Opg96Nl8kswkEMwRgnnQIvJDVx4Y1dj
         OeoqoLIYODBRuHQCicYWpcEPneGaLKDvyrz90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=LbMnIR0spr5diHeTXRfbyDPzHDIIQJ53o20LE3YI57Y=;
        b=iKADugpE6erht0UKFnX5mmNRoNuxTSDjpy+nx3VOuz8+rOMb4kKL/9C2bpae8tvOpX
         QhDGILatcUuvYZO3Wp9ukyBCaWb+FBNiPuyKa5kyZt+IG32x4nYrYbWxuuRld0hgsqET
         YlKmGhFCFFE64Wej0hyWGkWWJmZUSx1Tl2M0XF9nyTGxKtnDNgOIQgP4BeuV8CqsOKwl
         KDruqLUtnp4PvlIfP1esYtRNzkyxNEOCY3FtRaNQdswfr3roYd/E/Y2u9bXc4FJYA5hl
         An9NlkEL4D0HfboN7T2FPVLpnXPszhHqgxaVdfkqLSLz981pa6cKQMzCd89jM/cv25hD
         uwJw==
X-Gm-Message-State: ALKqPwcPUa0xs78WAhnU99s6VrDkd1R8nweP+OrvG0sJXB3jq/doSTdH
        V5t3ZwjXdZUVlyYFC+8f3ek60xRc64KG4uyhM2PinQ==
X-Google-Smtp-Source: AB8JxZq4swHGAKwY0XIDqI7vcPPa6tiNQD+EZpcLhWfBzpL24WCx+YvyZF2vJBuksn2O8JRb37tzFbFcWC7IDQ6NIVQ=
X-Received: by 2002:aca:3f89:: with SMTP id m131-v6mr8051736oia.95.1526734005011;
 Sat, 19 May 2018 05:46:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3c57:0:0:0:0:0 with HTTP; Sat, 19 May 2018 05:46:44
 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 19 May 2018 13:46:44 +0100
Message-ID: <CAE5ih7-xxVLvhYNb6Jek9z-jFDyyvbqD-MVL6RGDuA5td5stwQ@mail.gmail.com>
Subject: Re: Re :[PATCHv4 1/1] git-p4: add unshelve command
To:     "merlorom@yahoo.fr" <merlorom@yahoo.fr>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19 May 2018 at 12:26, merlorom@yahoo.fr <merlorom@yahoo.fr> wrote:
> Hi Luke,
>
> In the P4Unshelve classe, could you add an help description directly in t=
he
> optparse.add_option of --origin ?

Sure. I'll do a re-roll.


>
> From the workfow point of you, do you think it will be possible to make
> changes in the git branch of the unshelved CL (remotes/p4/unshelved/xxxx)=
,
> then update the p4 shelved CL directly ? It would be great.

That's an interesting idea. You would need to check it out somehow,
but then it should just work.

i.e.

$ git p4 unshelve NNNN
$ git checkout remotes/p4/unshelved/NNNN
$ vim foo.c
$ git commit --amend foo.c
$ git p4 submit --origin HEAD^ --update-shelve NNNN

I think it should work as-is.


>
> Romain
>
> Envoy=C3=A9 depuis Yahoo Mail pour Android
>
> Le sam., mai 19, 2018 =C3=A0 12:00, Luke Diamand
> <luke@diamand.org> a =C3=A9crit :
> This can be used to "unshelve" a shelved P4 commit into
> a git commit.
>
> For example:
>
>   $ git p4 unshelve 12345
>
> The resulting commit ends up in the branch:
>   refs/remotes/p4/unshelved/12345
>
> If that branch already exists, it is renamed - for example
> the above branch would be saved as p4/unshelved/12345.1.
>
> git-p4 checks that the shelved changelist is based on files
> which are at the same Perforce revision as the origin branch
> being used for the unshelve (HEAD by default). If they are not,
> it will refuse to unshelve. This is to ensure that the unshelved
> change does not contain other changes mixed-in.
>
> The reference branch can be changed manually with the "--origin"
> option.
>
> The change adds a new Unshelve command class. This just runs the
> existing P4Sync code tweaked to handle a shelved changelist.
>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
> Documentation/git-p4.txt |  32 ++++++
> git-p4.py                | 207 ++++++++++++++++++++++++++++++++-------
> t/t9832-unshelve.sh      | 153 +++++++++++++++++++++++++++++
> 3 files changed, 356 insertions(+), 36 deletions(-)
> create mode 100755 t/t9832-unshelve.sh
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index d8c8f11c9f..d3cb249fc2 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -164,6 +164,31 @@ $ git p4 submit --shelve
> $ git p4 submit --update-shelve 1234 --update-shelve 2345
> ----
>
> +
> +Unshelve
> +~~~~~~~~
> +Unshelving will take a shelved P4 changelist, and produce the equivalent
> git commit
> +in the branch refs/remotes/p4/unshelved/<changelist>.
> +
> +The git commit is created relative to the current origin revision (HEAD =
by
> default).
> +If the shelved changelist's parent revisions differ, git-p4 will refuse =
to
> unshelve;
> +you need to be unshelving onto an equivalent tree.
> +
> +The origin revision can be changed with the "--origin" option.
> +
> +If the target branch in refs/remotes/p4/unshelved already exists, the ol=
d
> one will
> +be renamed.
> +
> +----
> +$ git p4 sync
> +$ git p4 unshelve 12345
> +$ git show refs/remotes/p4/unshelved/12345
> +<submit more changes via p4 to the same files>
> +$ git p4 unshelve 12345
> +<refuses to unshelve until git is in sync with p4 again>
> +
> +----
> +
> OPTIONS
> -------
>
> @@ -337,6 +362,13 @@ These options can be used to modify 'git p4 rebase'
> behavior.
> --import-labels::
>     Import p4 labels.
>
> +Unshelve options
> +~~~~~~~~~~~~~~~~
> +
> +--origin::
> +    Sets the git refspec against which the shelved P4 changelist is
> compared.
> +    Defaults to p4/master.
> +
> DEPOT PATH SYNTAX
> -----------------
> The p4 depot path argument to 'git p4 sync' and 'git p4 clone' can
> diff --git a/git-p4.py b/git-p4.py
> index 7bb9cadc69..9390d58a84 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -316,12 +316,17 @@ def p4_last_change():
>     results =3D p4CmdList(["changes", "-m", "1"], skip_info=3DTrue)
>     return int(results[0]['change'])
>
> -def p4_describe(change):
> +def p4_describe(change, shelved=3DFalse):
>     """Make sure it returns a valid result by checking for
>         the presence of field "time".  Return a dict of the
>         results."""
>
> -    ds =3D p4CmdList(["describe", "-s", str(change)], skip_info=3DTrue)
> +    cmd =3D ["describe", "-s"]
> +    if shelved:
> +        cmd +=3D ["-S"]
> +    cmd +=3D [str(change)]
> +
> +    ds =3D p4CmdList(cmd, skip_info=3DTrue)
>     if len(ds) !=3D 1:
>         die("p4 describe -s %d did not return 1 result: %s" % (change,
> str(ds)))
>
> @@ -662,6 +667,12 @@ def gitBranchExists(branch):
>                             stderr=3Dsubprocess.PIPE, stdout=3Dsubprocess=
.PIPE);
>     return proc.wait() =3D=3D 0;
>
> +def gitUpdateRef(ref, newvalue):
> +    subprocess.check_call(["git", "update-ref", ref, newvalue])
> +
> +def gitDeleteRef(ref):
> +    subprocess.check_call(["git", "update-ref", "-d", ref])
> +
> _gitConfig =3D {}
>
> def gitConfig(key, typeSpecifier=3DNone):
> @@ -2411,6 +2422,7 @@ class P4Sync(Command, P4UserMap):
>         self.tempBranches =3D []
>         self.tempBranchLocation =3D "refs/git-p4-tmp"
>         self.largeFileSystem =3D None
> +        self.suppress_meta_comment =3D False
>
>         if gitConfig('git-p4.largeFileSystem'):
>             largeFileSystemConstructor =3D
> globals()[gitConfig('git-p4.largeFileSystem')]
> @@ -2421,6 +2433,18 @@ class P4Sync(Command, P4UserMap):
>         if gitConfig("git-p4.syncFromOrigin") =3D=3D "false":
>             self.syncWithOrigin =3D False
>
> +        self.depotPaths =3D []
> +        self.changeRange =3D ""
> +        self.previousDepotPaths =3D []
> +        self.hasOrigin =3D False
> +
> +        # map from branch depot path to parent branch
> +        self.knownBranches =3D {}
> +        self.initialParents =3D {}
> +
> +        self.tz =3D "%+03d%02d" % (- time.timezone / 3600, ((- time.time=
zone
> % 3600) / 60))
> +        self.labels =3D {}
> +
>     # Force a checkpoint in fast-import and wait for it to finish
>     def checkpoint(self):
>         self.gitStream.write("checkpoint\n\n")
> @@ -2429,7 +2453,20 @@ class P4Sync(Command, P4UserMap):
>         if self.verbose:
>             print "checkpoint finished: " + out
>
> -    def extractFilesFromCommit(self, commit):
> +    def cmp_shelved(self, path, filerev, revision):
> +        """ Determine if a path at revision #filerev is the same as the
> file
> +            at revision @revision for a shelved changelist. If they don'=
t
> match,
> +            unshelving won't be safe (we will get other changes mixed in=
).
> +
> +            This is comparing the revision that the shelved changelist i=
s
> *based* on, not
> +            the shelved changelist itself.
> +        """
> +        ret =3D p4Cmd(["diff2", "{0}#{1}".format(path, filerev),
> "{0}@{1}".format(path, revision)])
> +        if verbose:
> +            print("p4 diff2 %s %s %s =3D> %s" % (path, filerev, revision=
,
> ret))
> +        return ret["status"] =3D=3D "identical"
> +
> +    def extractFilesFromCommit(self, commit, shelved=3DFalse, shelved_cl=
 =3D 0,
> origin_revision =3D 0):
>         self.cloneExclude =3D [re.sub(r"\.\.\.$", "", path)
>                               for path in self.cloneExclude]
>         files =3D []
> @@ -2452,6 +2489,14 @@ class P4Sync(Command, P4UserMap):
>             file["rev"] =3D commit["rev%s" % fnum]
>             file["action"] =3D commit["action%s" % fnum]
>             file["type"] =3D commit["type%s" % fnum]
> +            if shelved:
> +                file["shelved_cl"] =3D int(shelved_cl)
> +
> +                if file["rev"] !=3D "none" and \
> +                    not self.cmp_shelved(path, file["rev"],
> origin_revision):
> +                    sys.exit("change {0} not based on {1} for {2}, canno=
t
> unshelve".format(
> +                        commit["change"], self.initialParent, path))
> +
>             files.append(file)
>             fnum =3D fnum + 1
>         return files
> @@ -2743,7 +2788,16 @@ class P4Sync(Command, P4UserMap):
>             def streamP4FilesCbSelf(entry):
>                 self.streamP4FilesCb(entry)
>
> -            fileArgs =3D ['%s#%s' % (f['path'], f['rev']) for f in
> filesToRead]
> +            fileArgs =3D []
> +            for f in filesToRead:
> +                if 'shelved_cl' in f:
> +                    # Handle shelved CLs using the "p4 print file@=3DN"
> syntax to print
> +                    # the contents
> +                    fileArg =3D '%s@=3D%d' % (f['path'], f['shelved_cl']=
)
> +                else:
> +                    fileArg =3D '%s#%s' % (f['path'], f['rev'])
> +
> +                fileArgs.append(fileArg)
>
>             p4CmdList(["-x", "-", "print"],
>                       stdin=3DfileArgs,
> @@ -2844,11 +2898,15 @@ class P4Sync(Command, P4UserMap):
>         self.gitStream.write(details["desc"])
>         if len(jobs) > 0:
>             self.gitStream.write("\nJobs: %s" % (' '.join(jobs)))
> -        self.gitStream.write("\n[git-p4: depot-paths =3D \"%s\": change =
=3D %s"
> %
> -                            (','.join(self.branchPrefixes),
> details["change"]))
> -        if len(details['options']) > 0:
> -            self.gitStream.write(": options =3D %s" % details['options']=
)
> -        self.gitStream.write("]\nEOT\n\n")
> +
> +        if not self.suppress_meta_comment:
> +            self.gitStream.write("\n[git-p4: depot-paths =3D \"%s\": cha=
nge =3D
> %s" %
> +                                (','.join(self.branchPrefixes),
> details["change"]))
> +            if len(details['options']) > 0:
> +                self.gitStream.write(": options =3D %s" % details['optio=
ns'])
> +            self.gitStream.write("]\n")
> +
> +        self.gitStream.write("EOT\n\n")
>
>         if len(parent) > 0:
>             if self.verbose:
> @@ -3162,10 +3220,10 @@ class P4Sync(Command, P4UserMap):
>         else:
>             return None
>
> -    def importChanges(self, changes):
> +    def importChanges(self, changes, shelved=3DFalse, origin_revision=3D=
0):
>         cnt =3D 1
>         for change in changes:
> -            description =3D p4_describe(change)
> +            description =3D p4_describe(change, shelved)
>             self.updateOptionDict(description)
>
>             if not self.silent:
> @@ -3235,7 +3293,7 @@ class P4Sync(Command, P4UserMap):
>                                 print "Parent of %s not found. Committing
> into head of %s" % (branch, parent)
>                             self.commit(description, filesForCommit, bran=
ch,
> parent)
>                 else:
> -                    files =3D self.extractFilesFromCommit(description)
> +                    files =3D self.extractFilesFromCommit(description,
> shelved, change, origin_revision)
>                     self.commit(description, files, self.branch,
>                                 self.initialParent)
>                     # only needed once, to connect to the previous commit
> @@ -3300,17 +3358,23 @@ class P4Sync(Command, P4UserMap):
>             print "IO error with git fast-import. Is your git version rec=
ent
> enough?"
>             print self.gitError.read()
>
> +    def openStreams(self):
> +        self.importProcess =3D subprocess.Popen(["git", "fast-import"],
> +                                              stdin=3Dsubprocess.PIPE,
> +                                              stdout=3Dsubprocess.PIPE,
> +                                              stderr=3Dsubprocess.PIPE);
> +        self.gitOutput =3D self.importProcess.stdout
> +        self.gitStream =3D self.importProcess.stdin
> +        self.gitError =3D self.importProcess.stderr
>
> -    def run(self, args):
> -        self.depotPaths =3D []
> -        self.changeRange =3D ""
> -        self.previousDepotPaths =3D []
> -        self.hasOrigin =3D False
> -
> -        # map from branch depot path to parent branch
> -        self.knownBranches =3D {}
> -        self.initialParents =3D {}
> +    def closeStreams(self):
> +        self.gitStream.close()
> +        if self.importProcess.wait() !=3D 0:
> +            die("fast-import failed: %s" % self.gitError.read())
> +        self.gitOutput.close()
> +        self.gitError.close()
>
> +    def run(self, args):
>         if self.importIntoRemotes:
>             self.refPrefix =3D "refs/remotes/p4/"
>         else:
> @@ -3497,15 +3561,7 @@ class P4Sync(Command, P4UserMap):
>                     b =3D b[len(self.projectName):]
>                 self.createdBranches.add(b)
>
> -        self.tz =3D "%+03d%02d" % (- time.timezone / 3600, ((- time.time=
zone
> % 3600) / 60))
> -
> -        self.importProcess =3D subprocess.Popen(["git", "fast-import"],
> -                                              stdin=3Dsubprocess.PIPE,
> -                                              stdout=3Dsubprocess.PIPE,
> -                                              stderr=3Dsubprocess.PIPE);
> -        self.gitOutput =3D self.importProcess.stdout
> -        self.gitStream =3D self.importProcess.stdin
> -        self.gitError =3D self.importProcess.stderr
> +        self.openStreams()
>
>         if revision:
>             self.importHeadRevision(revision)
> @@ -3585,11 +3641,7 @@ class P4Sync(Command, P4UserMap):
>             missingP4Labels =3D p4Labels - gitTags
>             self.importP4Labels(self.gitStream, missingP4Labels)
>
> -        self.gitStream.close()
> -        if self.importProcess.wait() !=3D 0:
> -            die("fast-import failed: %s" % self.gitError.read())
> -        self.gitOutput.close()
> -        self.gitError.close()
> +        self.closeStreams()
>
>         # Cleanup temporary branches created during import
>         if self.tempBranches !=3D []:
> @@ -3721,6 +3773,88 @@ class P4Clone(P4Sync):
>
>         return True
>
> +class P4Unshelve(Command):
> +    def __init__(self):
> +        Command.__init__(self)
> +        self.options =3D []
> +        self.description =3D "Unshelve a P4 changelist into a git commit=
"
> +        self.usage =3D "usage: %prog [options] changelist"
> +        self.options +=3D [
> +                optparse.make_option("--origin", dest=3D"origin"),
> +        ]
> +        self.verbose =3D False
> +        self.noCommit =3D False
> +        self.origin =3D "HEAD"
> +        self.destbranch =3D "refs/remotes/p4/unshelved"
> +
> +    def renameBranch(self, branch_name):
> +        """ Rename the existing branch to branch_name.N
> +        """
> +
> +        found =3D True
> +        for i in range(0,1000):
> +            backup_branch_name =3D "{0}.{1}".format(branch_name, i)
> +            if not gitBranchExists(backup_branch_name):
> +                gitUpdateRef(backup_branch_name, branch_name) # copy ref=
 to
> backup
> +                gitDeleteRef(branch_name)
> +                found =3D True
> +                print("renamed old unshelve branch to
> {0}".format(backup_branch_name))
> +                break
> +
> +        if not found:
> +            sys.exit("gave up trying to rename existing branch
> {0}".format(sync.branch))
> +
> +    def findLastP4Revision(self, starting_point):
> +        """ Look back from starting_point for the first commit created b=
y
> git-p4
> +            to find the P4 commit we are based on, and the depot-paths.
> +        """
> +
> +        for parent in (range(65535)):
> +            log =3D
> extractLogMessageFromGitCommit("{0}^{1}".format(starting_point, parent))
> +            settings =3D extractSettingsGitLog(log)
> +            if settings.has_key('change'):
> +                return settings
> +
> +        sys.exit("could not find git-p4 commits in
> {0}".format(self.origin))
> +
> +    def run(self, args):
> +        if len(args) !=3D 1:
> +            return False
> +
> +        if not gitBranchExists(self.origin):
> +            sys.exit("origin branch {0} does not
> exist".format(self.origin))
> +
> +        sync =3D P4Sync()
> +        changes =3D args
> +        sync.initialParent =3D self.origin
> +
> +        # use the first change in the list to construct the branch to
> unshelve into
> +        change =3D changes[0]
> +
> +        # if the target branch already exists, rename it
> +        branch_name =3D "{0}/{1}".format(self.destbranch, change)
> +        if gitBranchExists(branch_name):
> +            self.renameBranch(branch_name)
> +        sync.branch =3D branch_name
> +
> +        sync.verbose =3D self.verbose
> +        sync.suppress_meta_comment =3D True
> +
> +        settings =3D self.findLastP4Revision(self.origin)
> +        origin_revision =3D settings['change']
> +        sync.depotPaths =3D settings['depot-paths']
> +        sync.branchPrefixes =3D sync.depotPaths
> +
> +        sync.openStreams()
> +        sync.loadUserMapFromCache()
> +        sync.silent =3D True
> +        sync.importChanges(changes, shelved=3DTrue,
> origin_revision=3Dorigin_revision)
> +        sync.closeStreams()
> +
> +        print("unshelved changelist {0} into {1}".format(change,
> branch_name))
> +
> +        return True
> +
> class P4Branches(Command):
>     def __init__(self):
>         Command.__init__(self)
> @@ -3775,7 +3909,8 @@ commands =3D {
>     "rebase" : P4Rebase,
>     "clone" : P4Clone,
>     "rollback" : P4RollBack,
> -    "branches" : P4Branches
> +    "branches" : P4Branches,
> +    "unshelve" : P4Unshelve,
> }
>
>
> diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
> new file mode 100755
> index 0000000000..cca2dec536
> --- /dev/null
> +++ b/t/t9832-unshelve.sh
> @@ -0,0 +1,153 @@
> +#!/bin/sh
> +
> +last_shelved_change() {
> +    p4 changes -s shelved -m1 | cut -d " " -f 2
> +}
> +
> +test_description=3D'git p4 unshelve'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +    start_p4d
> +'
> +
> +test_expect_success 'init depot' '
> +    (
> +        cd "$cli" &&
> +        echo file1 >file1 &&
> +        p4 add file1 &&
> +        p4 submit -d "change 1"
> +        : >file_to_delete &&
> +        p4 add file_to_delete &&
> +        p4 submit -d "file to delete"
> +    )
> +'
> +
> +test_expect_success 'initial clone' '
> +    git p4 clone --dest=3D"$git" //depot/@all
> +'
> +
> +test_expect_success 'create shelved changelist' '
> +    (
> +        cd "$cli" &&
> +        p4 edit file1 &&
> +        echo "a change" >>file1 &&
> +        echo "new file" >file2 &&
> +        p4 add file2 &&
> +        p4 delete file_to_delete &&
> +        p4 opened &&
> +        p4 shelve -i <<EOF
> +Change: new
> +Description:
> +    Test commit
> +
> +    Further description
> +Files:
> +    //depot/file1
> +    //depot/file2
> +    //depot/file_to_delete
> +EOF
> +
> +    ) &&
> +    (
> +        cd "$git" &&
> +        change=3D$(last_shelved_change) &&
> +        git p4 unshelve $change &&
> +        git show refs/remotes/p4/unshelved/$change | grep -q "Further
> description" &&
> +        git cherry-pick refs/remotes/p4/unshelved/$change &&
> +        test_path_is_file file2 &&
> +        test_cmp file1 "$cli"/file1 &&
> +        test_cmp file2 "$cli"/file2 &&
> +        test_path_is_missing file_to_delete
> +    )
> +'
> +
> +test_expect_success 'update shelved changelist and re-unshelve' '
> +    test_when_finished cleanup_git &&
> +    (
> +        cd "$cli" &&
> +        change=3D$(last_shelved_change) &&
> +        echo "file3" >file3 &&
> +        p4 add -c $change file3 &&
> +        p4 shelve -i -r <<EOF &&
> +Change: $change
> +Description:
> +    Test commit
> +
> +    Further description
> +Files:
> +    //depot/file1
> +    //depot/file2
> +    //depot/file3
> +    //depot/file_to_delete
> +EOF
> +        p4 describe $change
> +    ) &&
> +    (
> +        cd "$git" &&
> +        change=3D$(last_shelved_change) &&
> +        git p4 unshelve $change &&
> +        git diff refs/remotes/p4/unshelved/$change.0
> refs/remotes/p4/unshelved/$change | grep -q file3
> +    )
> +'
> +
> +# This is the tricky case where the shelved changelist base revision
> doesn't
> +# match git-p4's idea of the base revision
> +#
> +# We will attempt to unshelve a change that is based on a change one com=
mit
> +# ahead of p4/master
> +
> +test_expect_success 'create shelved changelist based on p4 change ahead =
of
> p4/master' '
> +    git p4 clone --dest=3D"$git" //depot/@all &&
> +    (
> +        cd "$cli" &&
> +        p4 revert ... &&
> +        p4 edit file1 &&
> +        echo "foo" >>file1 &&
> +        p4 submit -d "change:foo" &&
> +        p4 edit file1 &&
> +        echo "bar" >>file1 &&
> +        p4 shelve -i <<EOF &&
> +Change: new
> +Description:
> +    Change to be unshelved
> +Files:
> +    //depot/file1
> +EOF
> +        change=3D$(last_shelved_change) &&
> +        p4 describe -S $change | grep -q "Change to be unshelved"
> +    )
> +'
> +
> +diff_adds_line() {
> +    text=3D"$1" &&
> +    file=3D"$2" &&
> +    grep -q "^+$text" $file || (echo "expected \"text\" $text not found =
in
> $file" && exit 1)
> +}
> +
> +diff_excludes_line() {
> +    text=3D"$1" &&
> +    file=3D"$2" &&
> +    if grep -q "^+$text" $file; then
> +        echo "unexpected text \"$text\" found in $file" &&
> +        exit 1
> +    fi
> +}
> +
> +# Now try to unshelve it. git-p4 should refuse to do so.
> +test_expect_success 'try to unshelve the change' '
> +    test_when_finished cleanup_git &&
> +    (
> +        change=3D$(last_shelved_change) &&
> +        cd "$git" &&
> +        ! git p4 unshelve $change >out.txt 2>&1 &&
> +        grep -q "cannot unshelve" out.txt
> +    )
> +'
> +
> +test_expect_success 'kill p4d' '
> +    kill_p4d
> +'
> +
> +test_done
> --
> 2.17.0.392.gdeb1a6e9b7
>
