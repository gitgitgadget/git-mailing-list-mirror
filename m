Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28E2E1FAE2
	for <e@80x24.org>; Mon, 12 Mar 2018 09:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeCLJk3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 05:40:29 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:38125 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbeCLJk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 05:40:26 -0400
Received: by mail-qk0-f172.google.com with SMTP id 132so735088qkd.5
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2PClG4U9ZDRfonGMWCTbk0Xj31C2nK/w5POWmPf5OgE=;
        b=Fxzdu2jTCfPCZX5pPPS0cdyWt4eIx7NunLhcxdoo1V5ofaKeuxZaLTxfl81zEJQJ5T
         So0ZmoT9CmH8zDfFQdcz/246tsY/yZ2QrieFL0v3ZIy9Fp5ywy40wAbLH0vOGJNQzvMs
         bt9sjjOr1BA27ViJ0ygCH4Aza5kJYRTIKNclI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2PClG4U9ZDRfonGMWCTbk0Xj31C2nK/w5POWmPf5OgE=;
        b=CuWuOlaiViEouWVi/7MCft9CkBzKIWeFkp46QvpML/sM1oFIPRXF/mODqvwK1dPmIo
         n/lx4/YI7kLyoo6N2LPCumT0k7Wujf09bfcqsn6e1j+ou0QTHlFGi7UYR+G2kGDE1WIp
         fNPx/J8sdcRSxEYBw200ohkczNWU7ElvcgPSLKiu24JWuhtp1v4t1VOwWpEEnnEghEjT
         s4mDU9YWNTm8sEupYZ69H05/Y9m4j9xG8lYA0fWTdHS1PKPNF2l14Vg9RmjaqbgnKTEa
         P2S8TuRH3bsQ/+I6tNzIqy7d0+mmdBmoXzU0Dn+Tgmi2V4o2kQuqXnzkTKrtCvpfNZjZ
         7IVw==
X-Gm-Message-State: AElRT7Et/PfnNoQJhe+8jjGxrOBKFUJgV7Hz3KOoDPtbFbHqEQtmB52t
        v6f/z74ISJIcOGGVbmAybAYvlSmwV3iaxiu0l2IxMQ==
X-Google-Smtp-Source: AG47ELvh89oJitASy/If6CpKH2PnPGIzgwaCNgnxfDpGZMUzEPtqC87rTLMEvS/RylBPbW1MTO/JGuWT8P6y3kY6iMc=
X-Received: by 10.55.194.8 with SMTP id i8mr8725823qkm.127.1520847625739; Mon,
 12 Mar 2018 02:40:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.36.141 with HTTP; Mon, 12 Mar 2018 02:40:25 -0700 (PDT)
In-Reply-To: <CAPig+cRt3cdKOCFmbuUMQPuBnP+weD3HcY-5kz9RMkPH=aP63g@mail.gmail.com>
References: <20180226114822.1617-1-luke@diamand.org> <20180226114822.1617-2-luke@diamand.org>
 <CAPig+cRt3cdKOCFmbuUMQPuBnP+weD3HcY-5kz9RMkPH=aP63g@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 12 Mar 2018 09:40:25 +0000
Message-ID: <CAE5ih7_49-85ayR9AdHjd0AUhmTua-5Mn_CjLXGcT571Lh=xzg@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-p4: add format-patch subcommand
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26 February 2018 at 23:48, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Feb 26, 2018 at 6:48 AM, Luke Diamand <luke@diamand.org> wrote:
>> It takes a list of P4 changelists and generates a patch for
>> each one, using "p4 describe".
>> [...]

Just to say that I almost got this working reasonably well, but it
gets pretty nasty making binary files work - in order to generate the
git binary format I need a base85 encoder which exists in Python3, but
not in Python2. And while I could obviously write it in Python easily
enough, it starts to feel like an awful lot of code implementing (and
maintaining) a slightly second-rate "git diff". And while it's
tempting to just not support binary files, in reality Perforce repos
seem to end up with lots of them.

So I think I might have another go at the previous scheme. What I will
have to do is to first create a faked-up commit representing the point
prior to the shelved commit for each file ("for file@rev-1 in files"),
and then create the real commit ("for file@rev in files"). It's
probably not as grim as it sounds and then means that we end up with
git doing all the hard work of diffing files, rather than relying on
Perforce's diff engine in conjunction with some Python.


>> Signed-off-by: Luke Diamand <luke@diamand.org>
>> ---
>> diff --git a/git-p4.py b/git-p4.py
>> @@ -3749,6 +3761,277 @@ class P4Branches(Command):
>> +class P4MakePatch(Command,P4UserMap):
>> +    def run(self, args):
>> +        if self.output and not os.path.isdir(self.output):
>> +            sys.exit("output directory %s does not exist" % self.output)
>
> For consistency with "git format-patch", this could create the output
> directory automatically rather than erroring out.
>
>> +        if self.strip_depot_prefix:
>> +            self.clientSpec = getClientSpec()
>> +        else:
>> +            self.clientSpec = None
>> +
>> +        self.loadUserMapFromCache()
>> +        if len(args) < 1:
>> +            return False
>
> Would it make sense to handle this no-arguments case earlier before
> doing work, such as loading the user map from cache?
>
>> +        for change in args:
>> +            self.make_patch(int(change))
>> +
>> +        return True
>> +
>> +    def p4_fetch_delta(self, change, files, shelved=False):
>> +        cmd = ["describe"]
>> +        if shelved:
>> +            cmd += ["-S"]
>> +        cmd += ["-du"]
>> +        cmd += ["%s" % change]
>> +        cmd = p4_build_cmd(cmd)
>> +
>> +        p4 = subprocess.Popen(cmd, shell=False, stdout=subprocess.PIPE)
>> +        try:
>> +            result = p4.stdout.readlines()
>> +        except EOFError:
>> +            pass
>> +        in_diff = False
>> +        matcher = re.compile('====\s+(.*)#(\d+)\s+\(text\)\s+====')
>> +        diffmatcher = re.compile("Differences ...")
>
> I'm not familiar with the output of "p4 describe", but does it include
> user-supplied text? If so, would it be safer to anchor 'diffmatcher',
> for instance, "^Diferences...$"?
>
>> +        delta = ""
>> +        skip_next_blank_line = False
>> +
>> +        for line in result:
>> +            if diffmatcher.match(line):
>
> Stepping back, does "Differences..." appear on a line of its own? If
> so, why does this need to be a regex at all? Can't it just do a direct
> string comparison?
>
>> +                in_diff = True
>> +                continue
>> +
>> +            if in_diff:
>> +
>> +                if skip_next_blank_line and \
>> +                    line.rstrip() == "":
>> +                    skip_next_blank_line = False
>> +                    continue
>> +
>> +                m = matcher.match(line)
>> +                if m:
>> +                    file = self.map_path(m.group(1))
>> +                    ver = m.group(2)
>> +                    delta += "diff --git a%s b%s\n" % (file, file)
>> +                    delta += "--- a%s\n" % file
>> +                    delta += "+++ b%s\n" % file
>> +                    skip_next_blank_line = True
>> +                else:
>> +                    delta += line
>> +
>> +        delta += "\n"
>> +
>> +        exitCode = p4.wait()
>> +        if exitCode != 0:
>> +            raise IOError("p4 '%s' command failed" % str(cmd))
>
> Since p4.stdout.readlines() gathered all output from the command
> before massaging it into Git format, can't the p4.wait() be done
> earlier, just after the output has been read?
>
>> +        return delta
>> +
>> +    def make_patch(self, change):
>> +        [...]
>> +        # add new or deleted files
>> +        for file in files:
>> +            [...]
>> +            if add or delete:
>> +                if add:
>> +                    [...]
>> +                else:
>> +                    [...]
>> +
>> +                [...]
>> +
>> +                if add:
>> +                    prefix = "+"
>> +                else:
>> +                    prefix = "-"
>> +
>> +                if delete:
>> +                    [...]
>> +                else:
>> +                    # added
>> +                    [...]
>> +
>> +                (lines, delta_content) = self.read_file_contents(prefix, path_rev)
>> +
>> +                if add:
>> +                    if lines > 0:
>> +                        delta += "@@ -0,0 +1,%d @@\n" % lines
>> +                else:
>> +                    delta += "@@ -1,%d +0,0 @@\n" % lines
>
> It's not clear why you sometimes check 'add' but other times 'delete'.
> Perhaps always used one or the other? For instance:
>
>     action = file["action"]
>     if action == "add" or action == "delete":
>         if action == "add":
>             before = "/dev/null"
>             ...
>         else
>             ...
>
>         delta += ...
>
>         if action == "add":
>             ...
>
> or something.
>
>> +                delta += delta_content
>> +
>> +        if self.output:
>> +            with open("%s/%s.patch" % (self.output, change), "w") as f:
>> +                f.write(delta)
>> +        else:
>> +            print(delta)
>> diff --git a/t/t9832-make-patch.sh b/t/t9832-make-patch.sh
>> @@ -0,0 +1,135 @@
>> +# Converting P4 changes into patches
>> +#
>> +# - added, deleted, modified files
>> +# - regular commits, shelved commits
>> +#
>> +# directories and symblinks don't yet work
>> +# binary files will never work
>
> s/symblinks/symlinks/
>
>> +test_expect_success 'init depot' '
>> +       (
>> +               cd "$cli" &&
>> +               echo file1 >file1 &&
>> +               p4 add file1 &&
>> +               p4 submit -d "change 1" &&                      # cl 1
>> +               cat >file_to_delete <<-EOF &&
>
> Using -\EOF would signal that you don't expect interpolation within the heredoc.
>
>> +               LINE1
>> +               LINE2
>> +               EOF
>> +               echo "non-empty" >file_to_delete &&
>> +               p4 add file_to_delete &&
>> +               p4 submit -d "change 2" &&                      # cl 2
>> +               p4 edit file1 &&
>> +               cat >>file1 <<-EOF &&
>> +               LINE1
>> +               LINE2
>> +               EOF
>> +               p4 submit -d "change 3" &&                      # cl 3
>> +               p4 delete file_to_delete &&
>> +               echo "file2" >file2 &&
>> +               p4 add file2 &&
>> +               p4 submit -d "change 4"                         # cl 4
>> +       )
>> +'
>> +test_expect_success 'add p4 symlink' '
>> +       (
>> +               cd "$cli" &&
>> +               echo "symlink_source" >symlink_source &&
>> +               ln -s symlink_source symlink &&
>
> Should this test be protected with the SYMLINKS prerequisite?
>
>> +               p4 add symlink_source symlink &&
>> +               p4 submit -d "add symlink"                      # cl 6
>> +       )
>> +'
>> +
>> +test_expect_success 'patch from symlink' '
>
> Ditto SYMLINKS?
>
>> +       test_when_finished cleanup_git &&
>> +       cd "$git" &&
>> +       (
>> +               git p4 format-patch 6 | patch -p1 &&
>> +               test_path_is_file depot/symlink_source &&
>> +               test -L depot/symlink
>> +       )
>> +'
