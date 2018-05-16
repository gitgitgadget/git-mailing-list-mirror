Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF1B11F406
	for <e@80x24.org>; Wed, 16 May 2018 20:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeEPUsy (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 16:48:54 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41008 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeEPUsx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 16:48:53 -0400
Received: by mail-ot0-f194.google.com with SMTP id t1-v6so2538847oth.8
        for <git@vger.kernel.org>; Wed, 16 May 2018 13:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xmYnYoBwd9qAr8Jh0j6Y8AoTqb+2743Zu406o2DwmTs=;
        b=hj4NBLHjjMUZM8MPW9WwkGrEdZ2F1px2EV0wPxEgMa7dNqK2mkoNz/fnQvFcwSXDL6
         +5VPLmWlzHkBsRuFXnm9sguPHq2jUq2Jpq6arzN2okgyLy4jojzewq6kPzhttALCFdat
         R+8XbBX8WNIj541QLYNlLMH7KYFU+9bOYicag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xmYnYoBwd9qAr8Jh0j6Y8AoTqb+2743Zu406o2DwmTs=;
        b=Ynvdl6AXO5jzASAfzIf4FkJqL6WAiCKD3BrJZ2NlfIG3pfylYGS0WR1U/jBOiHfZ5r
         UBNigKjEkklsDvfQBBLAiLv4zxL30Tles2XuhzrLB8hX2hOnU+4DeMK35/BLQqU9y8L7
         bGPssLnOheBOP96g8VyZ+aHR+6a9QaobLAHQu71HgNwTsrNvvHUd6ICsCxv4Kqx4s4xt
         vV+A5OeP4k7Z+n/SWNj7Qsv7NPWXbg3G6/6XNCJxYkwXwGCMsp6IVfrEyFnD7lMbTX/l
         LqCaQ+FNZlWf62CdQIpvAkB4yLHe+nltauCOFR6hunE380F61b03tLHuzV/DEDbIw6+A
         B7Gg==
X-Gm-Message-State: ALKqPwfhP6dBeh8dIBEOBbe2up7Bs5NCKcpbcxFJ8ozjWd4GMyC1Mjw8
        /vigr6CAbl6NGF8L1fP4wZ3FYbcDjpQzxWm63iJMtg==
X-Google-Smtp-Source: AB8JxZqRroxpD47o1AtsZLTxnG48tUjcLtlpe31LXYEm0CZe3D2A3Bih2v8zbKAHqr0jOjUSuOWxq0RPZPrML+UsP3k=
X-Received: by 2002:a9d:c41:: with SMTP id 59-v6mr1841041otr.255.1526503732409;
 Wed, 16 May 2018 13:48:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3c57:0:0:0:0:0 with HTTP; Wed, 16 May 2018 13:48:51
 -0700 (PDT)
In-Reply-To: <1378098185.1161438.1526219571066@mail.yahoo.com>
References: <20180512212434.28012-1-luke@diamand.org> <20180512212434.28012-2-luke@diamand.org>
 <1378098185.1161438.1526219571066@mail.yahoo.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 16 May 2018 21:48:51 +0100
Message-ID: <CAE5ih79MTtDKRUYVhB7miuqYxhxZGrVtstG6Tn02LBv2kXrCfA@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-p4: add unshelve command
To:     Merland Romain <merlorom@yahoo.fr>
Cc:     Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Junio C Hamano <gitster@pobox.com>,
        "Cedric.Borgese@gmail.com" <Cedric.Borgese@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 May 2018 at 14:52, Merland Romain <merlorom@yahoo.fr> wrote:
> Hello Luke,
>
> Very interseting
> This is indeed an option we are waiting since the introduction of option =
--shelve for git p4 submit
> What I like most in your approach is the preservation of link to p4/maste=
r inducing small changes of git-p4 existing functions already heavily teste=
d.
> Also I like the dedicated branch you create, it is cleaner and then we ca=
n cherry-pick in other git branches.

Thanks, I'd be interested to know how you get on with it!

> We made some basic tries on our side, just adding an option --unshelve to=
 P4Submit (for simplicity, but I like much more your P4Unshelve class)
> and trying to use the diff of p4 to generate a patch when possible, then =
apply it in the current git branch on top of HEAD.
> Here it is, hope it can help a bit.
> Note it also uses p4 print -o for binary files.

I did try something like this earlier this year (if you look in the
archives you'll find it) but I found that it was getting quite
complicated trying to construct a sensible looking patch file from the
output of p4 describe. Better to let git's existing tools do that, as
they're going to be better than any half-baked attempt I might manage
in Python!

Thanks!
Luke



>
> diff --git a/git-p4.py b/git-p4.py
> index f4a6f3b4c..b466b46e1 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1353,6 +1353,8 @@ class P4Submit(Command, P4UserMap):
>                                       metavar=3D"CHANGELIST",
>                                       help=3D"update an existing shelved =
changelist, implies --shelve, "
>                                             "repeat in-order for multiple=
 shelved changelists"),
> +                optparse.make_option("--unshelve", dest=3D"unshelve",
> +                                     help=3D"unshelve speficied ChangeLi=
st into current BRANCH."),
>                  optparse.make_option("--commit", dest=3D"commit", metava=
r=3D"COMMIT",
>                                       help=3D"submit only the specified c=
ommit(s), one commit or xxx..xxx"),
>                  optparse.make_option("--disable-rebase", dest=3D"disable=
_rebase", action=3D"store_true",
> @@ -1367,6 +1369,7 @@ class P4Submit(Command, P4UserMap):
>          self.dry_run =3D False
>          self.shelve =3D False
>          self.update_shelve =3D list()
> +        self.unshelve =3D ""
>          self.commit =3D ""
>          self.disable_rebase =3D False
>          self.prepare_p4_only =3D False
> @@ -2083,6 +2086,66 @@ class P4Submit(Command, P4UserMap):
>          if self.clientPath =3D=3D "":
>              die("Error: Cannot locate perforce checkout of %s in client =
view" % self.depotPath)
>
> +        # special case of unshelving
> +        # todo: put this code in a class like P4Sync or P4Rebase
> +        if self.unshelve !=3D "":
> +            git_dir =3D os.getcwd() + '/'
> +            print "Importing shelved CL %s into current git branch %s" %=
 (self.unshelve, self.master)
> +            description =3D p4_describe(self.unshelve)
> +
> +            # get changed files
> +            files =3D p4CmdList(['files', "@=3D%s" % self.unshelve])
> +            editedFiles =3D []
> +            filesToAdd =3D []
> +            filesToDelete =3D []
> +            binaryFiles =3D []
> +            something_to_commit =3D False
> +            for f in files:
> +                if not f["depotFile"].startswith(self.depotPath):
> +                    print "WARNING: file %s not in this p4 depot - skipp=
ing" % f["depotFile"]
> +                    continue
> +
> +                elif f["action"] =3D=3D 'delete':
> +                    filesToDelete.append(f)
> +                    something_to_commit =3D True
> +                elif f["action"] =3D=3D 'add':
> +                    filesToAdd.append(f)
> +                    something_to_commit =3D True
> +                elif f["type"] =3D=3D 'binary':
> +                    binaryFiles.append(f)
> +                    something_to_commit =3D True
> +                elif f["action"] =3D=3D 'edit':
> +                    editedFiles.append(f)
> +                    something_to_commit =3D True
> +
> +                f["clientFile"] =3D f["depotFile"].replace(self.depotPat=
h,self.clientPath)
> +                f["gitFile"] =3D f["depotFile"].replace(self.depotPath,g=
it_dir)
> +
> +            if not something_to_commit:
> +                print "Nothing to commit. Exiting"
> +                return True
> +
> +            # get the diff and copy to diff directory
> +            for f in editedFiles:
> +                p4diff =3D p4_read_pipe(['diff2', '-du', f["depotFile"]+=
'#'+f["rev"], f["depotFile"]+'@=3D'+self.unshelve])
> +                p4diff =3D "\n".join(p4diff.split("\n")[1:])
> +                p4diff =3D '--- '+f["gitFile"]+'\n' + '+++ '+f["gitFile"=
]+'\n' + p4diff
> +                write_pipe(['patch', '-d/', '-p0'], p4diff)
> +                write_pipe(['git', 'add', '-f', f["gitFile"]], "")
> +            for f in filesToAdd:
> +                p4_write_pipe(['print', '-o', f["gitFile"], f["depotFile=
"]+'@=3D'+self.unshelve], "")
> +                write_pipe(['git', 'add', '-f', f["gitFile"]], "")
> +            for f in filesToDelete:
> +                os.remove(f["gitFile"])
> +                write_pipe(['git', 'rm', f["gitFile"]], "")
> +            for f in binaryFiles:
> +                p4_write_pipe(['print', '-o', f["gitFile"], f["depotFile=
"]+'@=3D'+self.unshelve], "")
> +                write_pipe(['git', 'add', '-f', f["gitFile"]], "")
> +
> +            # finalize: commit in git
> +            write_pipe(['git', 'commit', '-m', description["desc"]], "")
> +            return True
> +
>          print "Perforce checkout for depot path %s located at %s" % (sel=
f.depotPath, self.clientPath)
>          self.oldWorkingDirectory =3D os.getcwd()
>
> Romain
>
>
>
> Le samedi 12 mai 2018 =C3=A0 23:24:48 UTC+2, Luke Diamand <luke@diamand.o=
rg> a =C3=A9crit :
>
>
>
>
>
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
> Caveat:
>
> The unshelving is done against the current "p4/master" branch;
> git-p4 uses "p4 print" to get the file contents at the requested
> revision, and then fast-import creates a commit relative to p4/master.
>
> Ideally what you would want is for fast-import to create the
> commit based on the Perforce "revision" prior to the shelved commit,
> but Perforce doesn't have such a concept - to do this, git-p4
> would need to figure out the revisions of the individual files
> before the shelved changelist, and then construct a temporary
> git branch which matched this.
>
> It's possible to do this, but doing so makes this change a lot more
> complicated.
>
> This limitation means that if you unshelve a change where some
> of the changed files were not based on p4/master, you will get
> an amalgam of the change you wanted, and these other changes.
>
> The reference branch can be changed manually with the "--origin"
> option.
>
> The change adds a new Unshelve command class. This just runs the
> existing P4Sync code tweaked to handle a shelved changelist.
>
> Signed-off-by: Luke Diamand <luke@diamand.org>
