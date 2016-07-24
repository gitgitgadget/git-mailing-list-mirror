Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 807D0203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 18:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbcGXSg5 (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 14:36:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36469 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbcGXSg4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2016 14:36:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so13652588wma.3
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 11:36:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VrQutL7CCLeuF4iSTP5xVfq/V0qRzUHApv1TFLxRqLs=;
        b=XtDbQzNNiw4M8hEEvMUTTMIyUOlX7vfgd3YEqs24vEf57Hivbt9Y9h9BQDkyW3DHqz
         pjEEBShotVNQGRsaLvYb24hB5nIVmPd/uyPJMHe0VghO/ZXQzyuHXuatbxcQo5wYxr5m
         5Rravoj4hpHgNPr5SDRW3ScwztIDO0J9m8h7GuIPW6fvCmpjraH8+Tjn5MqaCfysL3Zt
         NYPBd6Wav8Evb1FMaZUBLZ7Ss8qaYAuRQS8d10OPLJ5Z09rI06Pmm9LulKlQvchQg8Iq
         036sKNfPCDFRO4oFR7V1wzNz4NltGiA+IrDo3+qZ+Sywxn5SSi9DIqgyzslSfWDsobUB
         pebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VrQutL7CCLeuF4iSTP5xVfq/V0qRzUHApv1TFLxRqLs=;
        b=hg4bh2PfTXyfdnl6TGKxKr03eZtQMpqo5LUGxkWZAaCLs6XigVYWI8ktpbngKDVBzR
         hc/16ZDlfYq7VneOHb0csBPJd7h6YretX8CVaKZEQqkPbj/9BIwTNzv+oXdqOXqqAadr
         EKpSXMp7GCcCQ2njWwyi3i1LaC4VwO1Rjd7GGwU1XZWMZ825sr/yg3CXe5NTxip4nvIE
         LxahqWbIl7KTNq1FbIGKiW+l1aTaLmUpfG8d3AYG5ayEXr5nkbLV8JCyjTccp4CwPGle
         gtNk8/mYhoD/2OyAh7MJv3G+4IsTDlo8iADuytBCSpn0IF7zpgb14Ctq0jn7QKOIi1+5
         3aiw==
X-Gm-Message-State: AEkoouv9OnrmyGkjIHq1EqC1EUymUTnUC+uzfLJKbwmsVp1ejlo7cOqWZHzqLFBhGhWusw==
X-Received: by 10.194.148.232 with SMTP id tv8mr13399697wjb.113.1469385414123;
        Sun, 24 Jul 2016 11:36:54 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB5F1D.dip0.t-ipconnect.de. [93.219.95.29])
        by smtp.gmail.com with ESMTPSA id bw9sm11826126wjc.33.2016.07.24.11.36.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jul 2016 11:36:53 -0700 (PDT)
Content-Type: text/plain; charset=iso-8859-2
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <5792B622.5040306@gmail.com>
Date:	Sun, 24 Jul 2016 20:36:50 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?iso-8859-2?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <0FB8A921-3465-4081-A36D-D2F19A8ED63D@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160722154900.19477-4-larsxschneider@gmail.com> <5792B622.5040306@gmail.com>
To:	=?iso-8859-2?Q?Jakub_Nar=EAbski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 23 Jul 2016, at 02:11, Jakub Narêbski <jnareb@gmail.com> wrote:

> W dniu 2016-07-22 o 17:49, larsxschneider@gmail.com pisze:
>> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Nb. this line is only needed if you want author name and/or date
> different from the email sender, or if you have sender line misconfigured
> (e.g. lacking the human readable name).

I use "git format-patch" to generate these emails:

git format-patch --cover-letter --subject-prefix="PATCH ..." -M $BASE -o $OUTPUT

How would I disable this line? (I already checked the man page to no avail).
Plus, what does "Nb" stand for? :-)


>> Git's clean/smudge mechanism invokes an external filter process for every
>> single blob that is affected by a filter. If Git filters a lot of blobs
>> then the startup time of the external filter processes can become a
>> significant part of the overall Git execution time.
> 
> Do I understand it correctly (from the commit description) that with
> this new option you start one filter process for the whole life of
> the Git command (e.g. `git add .`), which may perform more than one
> cleanup, but do not create a daemon or daemon-like process which
> would live for several commands invocations?

Correct!


>> This patch adds the filter.<driver>.useProtocol option which, if enabled,
>> keeps the external filter process running and processes all blobs with
>> the following protocol over stdin/stdout.
> 
> I agree with Junio that the name "useProtocol" is bad, and not quite
> right. Perhaps "persistent" would be better? Also, what is the value
> of `filter.<driver>.useProtocol`: boolean? or a script name?

I agree that the name is not ideal. "UseProtocol" as it is would be a boolean. 
I thought about "persistent" but this name wouldn't convey the scope of the 
persistency ("persistent for one Git operation" vs. "persistent for many Git 
operations"). What do you think about the protocol as int version idea
described in $gmane/300155 ?


> I also agree that we might wat to be able to keep clean and smudge
> filters separate, but be able to run a single program if they are
> both the same. I think there is a special case for filter unset,
> and/or filter being "cat" -- we would want to keep that.

Since 1a8630d there is a more efficient way to unset a filter ;-)
Can you think of other cases where the separation would be useful?


> My proposal is to use `filter.<driver>.persistent` as an addition
> to 'clean' and 'smudge' variables, with the following possible
> values:
> 
>  * none (the default)
>  * clean
>  * smudge
>  * both

That could work. However, I am not convinced, yet, that separate
filters are an actual use case.


> I assume that either Git would have to start multiple filter
> commands for multi-threaded operation, or the protocol would have
> to be extended to make persistent filter fork itself.

I think it would be better to have Git start multiple filter commands
to keep the protocol as simple and error free as possible.


> BTW. what would happen in your original proposal if the user had
> *both* filter.<driver>.useProtocol and filter.<driver>.smudge
> (and/or filter.<driver>.clean) set?

That wouldn't be an issue as "useProtocol" is just a boolean that
tells Git how to talk to "filter.<driver>.smudge" and "filter.<driver>.clean".
I need to make this more clear in the documentation.


>> 1. Git starts the filter on first usage and expects a welcome message
>> with protocol version number:
>> 	Git <-- Filter: "git-filter-protocol\n"
>> 	Git <-- Filter: "version 1"
> 
> I was wondering how Git would know that filter executable was started,
> but then I realized it was once-per-command invocation, not a daemon.
> 
> I agree with Torsten that there should be a terminator after the
> version number.

I agree, too :)


> Also, for future extendability this should be probably followed by
> possibly empty list of script capabilities, that is:
> 
> 	Git <-- Filter: "git-filter-protocol\n"
> 	Git <-- Filter: "version 1.1\n"
> 	Git <-- Filter: "capabilities clean smudge\n"
> 
> Or we can add capabilities in later version...

That is an interesting idea. My initial thought was to make the capabilities
of a certain version fix. If we want to add new capabilities then we would 
bump the version. I wonder what others think about your suggestion!


> BTW. why not follow e.g. HTTP protocol example, and use
> 
> 	Git <-- Filter: "git-filter-protocol/1\n"

I think my proposal is a bit more explicit as it states "version". If
you feel strongly about it, I could be convinced otherwise.


>> 2. Git sends the command (either "smudge" or "clean"), the filename, the
>> content size in bytes, and the content separated by a newline character:
>> 	Git --> Filter: "smudge\n"
> 
> Would it help (for some cases) to pass the name of filter that
> is being invoked?

Interesting thought! Can you imagine a case where this would be useful?


>> 	Git --> Filter: "testfile.dat\n"
> 
> Unfortunately, while sane filenames should not contain newlines[1],
> the unfortunate fact is that *filenames can include newlines*, and
> you need to be able to handle that[2].  Therefore you need either to
> choose a different separator (the only one that can be safely used
> is "\0", i.e. the NUL character - but it is not something easy to
> handle by shell scripts), or C-quote filenames as needed, or always
> C-quote filenames.  C-quoting at minimum should include quoting newline
> character, and the escape character itself.
> 
> BTW. is it the basename of a file, or a full pathname?
> 
> [1]: http://www.dwheeler.com/essays/fixing-unix-linux-filenames.html
> [2]: http://www.dwheeler.com/essays/filenames-in-shell.html

Thanks for this explanation. A bash version of the protocol is not
trivial (I tried it but ended up using Perl). Therefore I think "\0"
would be a good choice?


>> 	Git --> Filter: "7\n"
> 
> That's the content size in bytes written as an ASCII number.

Correct.


>> 	Git --> Filter: "CONTENT"
> 
> Can filter ignore the content size, and just read all what it was
> sent, that is until eof or something?

What would that something be? Since CONTENT is binary it can contain
any character (even "\0")...


>> 3. The filter is expected to answer with the result content size in
>> bytes and the result content separated by a newline character:
>> 	Git <-- Filter: "15\n"
>> 	Git <-- Filter: "SMUDGED_CONTENT"
> 
> I wonder how hard would be to write filters for this protocol...

Easy :-) Plus you can look at a Perl (see t/t0021) and a golang implementation
already (https://github.com/github/git-lfs/pull/1382).


>> 4. The filter is expected to wait for the next file in step 2, again.
>> 
>> Please note that the protocol filters do not support stream processing
>> with this implemenatation because the filter needs to know the length of
>            ^^^^^^^^~^^^^^^
> 
> implementation
Thanks!


>> the result in advance. A protocol version 2 could address this in a
>> future patch.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> Helped-by: Martin-Louis Bright <mlbright@gmail.com>
>> ---
>> Documentation/gitattributes.txt |  41 +++++++-
>> convert.c                       | 210 ++++++++++++++++++++++++++++++++++++++--
>> t/t0021-conversion.sh           | 170 ++++++++++++++++++++++++++++++++
> 
> Wouldn't it be better to name the test case something more
> descriptive, for example
> 
>   t/t0021-filter-driver-useProtocol.sh
> 
> The name of test should be adjusted to final name of the feature,
> of course.

I think the prefix numbers should be unique, no? And t0022 is already taken.


>> t/t0021/rot13.pl                |  80 +++++++++++++++
>> 4 files changed, 494 insertions(+), 7 deletions(-)
>> create mode 100755 t/t0021/rot13.pl
>> 
>> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
>> index 8882a3e..7026d62 100644
>> --- a/Documentation/gitattributes.txt
>> +++ b/Documentation/gitattributes.txt
>> @@ -300,7 +300,10 @@ checkout, when the `smudge` command is specified, the command is
>> fed the blob object from its standard input, and its standard
>> output is used to update the worktree file.  Similarly, the
>> `clean` command is used to convert the contents of worktree file
>> -upon checkin.
>> +upon checkin. By default these commands process only a single
>> +blob and terminate. If the setting filter.<driver>.useProtocol is
>> +enabled then Git can process all blobs with a single filter command
>> +invocation (see filter protocol below).
> 
> This does not tell the precedence between `smudge`, `clean` and
> filter.<driver>.useProtocol, see above. Also, discrepancy in how
> config variables are referenced.

As mentioned above "useProtocol" is a boolean. Therefore precedence shouldn't
be a problem. What do you mean by "discrepancy in how config variables are 
referenced"?


>> One use of the content filtering is to massage the content into a shape
>> that is more convenient for the platform, filesystem, and the user to use.
>> @@ -375,6 +378,42 @@ substitution.  For example:
>> ------------------------
>> 
>> 
>> +Filter Protocol
>> +^^^^^^^^^^^^^^^
>> +
>> +If the setting filter.<driver>.useProtocol is enabled then Git
> 
> This seems to tell that `useProtocol` is boolean-valued (?)

Correct.


>> +can process all blobs with a single filter command invocation
>> +by talking with the following protocol over stdin/stdout.
> 
> Should we use stdin/stdout shortcut, or spell standard input
> and standard output in full?

I think the documentation is not consistent here but spelled in full
seems to be used more often. I will change it!


>> diff --git a/convert.c b/convert.c
>> index 522e2c5..91ce86f 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -481,12 +481,188 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
>> 	return ret;
>> }
>> 
>> +static int cmd_process_map_init = 0;
>> +static struct hashmap cmd_process_map;
>> +
>> +struct cmd2process {
>> +	struct hashmap_entry ent; /* must be the first member! */
>> +	const char *cmd;
>> +	long protocol;
>> +	struct child_process process;
>> +};
> [...]
>> +static struct cmd2process *find_protocol_filter_entry(const char *cmd)
>> +{
>> +	struct cmd2process k;
>> +	hashmap_entry_init(&k, strhash(cmd));
>> +	k.cmd = cmd;
>> +	return hashmap_get(&cmd_process_map, &k, NULL);
> 
> Should we use global variable cmd_process_map, or pass it as parameter?
> The same question apply for other procedures and functions.
> 
> Note that I am not saying that it is a bad thing to use global
> variable here.

Passing it would be nicer as this would make at least a few functions "pure".
I will change that!


> [...]
>> +static struct cmd2process *start_protocol_filter(const char *cmd)
>> +{
>> +	int ret = 1;
>> +	struct cmd2process *entry = NULL;
>> +	struct child_process *process = NULL;
>> +	struct strbuf nbuf = STRBUF_INIT;
>> +	struct string_list split = STRING_LIST_INIT_NODUP;
>> +	const char *argv[] = { NULL, NULL };
>> +	const char *header = "git-filter-protocol\nversion";
>> +
>> +	entry = xmalloc(sizeof(*entry));
>> +	hashmap_entry_init(entry, strhash(cmd));
>> +	entry->cmd = cmd;
>> +	process = &entry->process;
>> +
>> +	child_process_init(process);
>> +	argv[0] = cmd;
>> +	process->argv = argv;
>> +	process->use_shell = 1;
>> +	process->in = -1;
>> +	process->out = -1;
>> +
>> +	if (start_command(process)) {
>> +		error("cannot fork to run external persistent filter '%s'", cmd);
>> +		return NULL;
>> +	}
>> +	strbuf_reset(&nbuf);
> 
> Is strbuf_reset needed here? We have not used nbuf variable yet.

Agreed, not needed!


>> +
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +	ret &= strbuf_read_once(&nbuf, process->out, 0) > 0;
>> +	sigchain_pop(SIGPIPE);
>> +
>> +	strbuf_stripspace(&nbuf, 0);
>> +	string_list_split_in_place(&split, nbuf.buf, ' ', 2);
>> +	ret &= split.nr > 1;
>> +	ret &= strncmp(header, split.items[0].string, strlen(header)) == 0;
>> +	if (ret) {
>> +		entry->protocol = strtol(split.items[1].string, NULL, 10);
> 
> This does not handle at least some errors in version number parsing,
> for example junk after version number. Don't we have some helper
> functions for this?

I am not sure. I haven't found one.

> Nb. this code makes it so that the version number must be integer.

Nb? :-)


>> +		switch (entry->protocol) {
>> +			case 1:
>> +				break;
>> +			default:
>> +				ret = 0;
>> +				error("unsupported protocol version %s for external persistent filter '%s'",
>> +					nbuf.buf, cmd);
>> +		}
>> +	}
>> +	string_list_clear(&split, 0);
>> +	strbuf_release(&nbuf);
>> +
>> +	if (!ret) {
>> +		error("initialization for external persistent filter '%s' failed", cmd);
>> +		return NULL;
>> +	}
> 
> Do we handle persistent filter command being killed before it finishes?
> Or exiting with error? I don't know this Git API...

If the "apply_filter" function fails then Git would proceed and just not
filter the content. If you define the "required" flag for the filter then
Git would error in that case.


>> +
>> +	hashmap_add(&cmd_process_map, entry);
>> +	return entry;
>> +}
> [...]
> 
>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>> index a05a8d2..d9077ea 100755
>> --- a/t/t0021-conversion.sh
>> +++ b/t/t0021-conversion.sh
>> @@ -268,4 +268,174 @@ test_expect_success 'disable filter with empty override' '
>> 	test_must_be_empty err
>> '
>> 
>> +test_expect_success 'required protocol filter should filter data' '
>> +	test_config_global filter.protocol.smudge \"$TEST_DIRECTORY/t0021/rot13.pl\" &&
>> +	test_config_global filter.protocol.clean \"$TEST_DIRECTORY/t0021/rot13.pl\" &&
> 
> Perhaps align it?
> 
>  +	test_config_global filter.protocol.clean  \"$TEST_DIRECTORY/t0021/rot13.pl\" &&

OK.


>> diff --git a/t/t0021/rot13.pl b/t/t0021/rot13.pl
> 
> That's bit more than rot13... but it might be O.K. for a filename here.

"rot13-$FEATURE_NAME.pl" ?


>> new file mode 100755
>> index 0000000..f2d7a03
>> --- /dev/null
>> +++ b/t/t0021/rot13.pl
>> @@ -0,0 +1,80 @@
>> +#!/usr/bin/env perl
> 
> Don't we use other way to specify perl path for Git, and for its
> test suite?

Other tests use "#!/usr/bin/perl" - I will change that.
See $gmane/300156.


>> +#
>> +# Example implementation for the Git filter protocol version 1
>> +# See Documentation/gitattributes.txt, section "Filter Protocol"
>> +#
>> +
>> +use strict;
>> +use warnings;
>> +use autodie;
> 
> autodie?

See $gmane/300124.


>> +
>> +sub rot13 {
>> +    my ($str) = @_;
>> +    $str =~ y/A-Za-z/N-ZA-Mn-za-m/;
>> +    return $str;
>> +}
>> +
>> +$| = 1; # autoflush STDOUT
> 
> Perhaps *STDOUT->autoflush(1), if I remember my Perl correctly?
> Should this matter? Why it is needed?

As recommended by Eric in $gmane/300124 I will run flush explicitly.


>> +
>> +open my $debug, ">>", "output.log";
>> +$debug->autoflush(1);
>> +
>> +print $debug "start\n";
>> +
>> +print STDOUT "git-filter-protocol\nversion 1";
>> +print $debug "wrote version\n";
>> +
>> +while (1) {
>> +    my $command = <STDIN>;
>> +    unless (defined($command)) {
>> +        exit();
>> +    }
>> +    chomp $command;
>> +    print $debug "IN: $command";
>> +    my $filename = <STDIN>;
>> +    chomp $filename;
>> +    print $debug " $filename";
>> +    my $filelen  = <STDIN>;
>> +    chomp $filelen;
>> +    print $debug " $filelen";
>> +
>> +    $filelen = int($filelen);
>> +    my $output;
>> +
>> +    if ( $filelen > 0 ) {
> 
> Inconsistent style. You use
> 
>       unless (defined($command)) {
> 
> without extra whitespace after and before parentheses, but
> 
>       if ( $filelen > 0 ) {
> 
> instead of simply
> 
>       if ($filelen > 0) {

Agreed. I will fix it.


>> +        my $input;
>> +        {
>> +            binmode(STDIN);
>> +            my $bytes_read = 0;
>> +            $bytes_read = read STDIN, $input, $filelen;
>> +            if ( $bytes_read != $filelen ) {
>> +                die "not enough to read";
> 
> I know it's only a test script (well, a part of one), but we would probably
> want to have more information in the case of a real filter.

True. Do you think there is anything to change in the script, though?


> 
>> +            }
>> +            print $debug " [OK] -- ";
>> +        }
>> +
>> +        if ( $command eq "clean") {
>> +            $output = rot13($input);
>> +        }
>> +        elsif ( $command eq "smudge" ) {
> 
> Style; I think we use
> 
>  +        } elsif ( $command eq "smudge" ) {

OK.


> 
>> +            $output = rot13($input);
>> +        }
>> +        else {
>> +            die "bad command\n";
> 
> Same here (both about style, and error message).
> 
>> +        }
>> +    }
> 
> What happens if $filelen is zero, or negative? Ah, I see that $output
> would be undef... which is bad, I think.

Is this something we need to consider in the test script?


>> +
>> +    my $output_len = length($output);
>> +    print STDOUT "$output_len\n";
>> +    print $debug "OUT: $output_len";
>> +    if ( $output_len > 0 ) {
>> +        if ( ($command eq "clean" and $filename eq "clean-write-fail.r") or
>> +             ($command eq "smudge" and $filename eq "smudge-write-fail.r") ) {
> 
> Hardcoded filenames, without it being described in the file header?

Good point! I will add a comment!

> 
>> +            print STDOUT "fail";
> 
> This is not defined in the protocol description!  Unless anything that
> does not conform to the specification would work here, but at least it
> is a recommended practice to be described in the documentation, don't
> you think?
> 
> What would happen in $output_len is 4?

Then it would work :D
I understand your point. However, this is not a reference implementation.
It is a test script that is supposed to trigger bad behavior which we can test. 
Therefore, I would argue that such a return value is OK. I will document it in 
the header, though. 


Thanks a lot for your extensive review,
Lars