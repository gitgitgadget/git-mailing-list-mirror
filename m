From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH v2 3/3] pretty: add aliases for pretty formats
Date: Mon, 26 Apr 2010 09:15:04 +0100
Message-ID: <i2x5b9751661004260115o6a195e21q52e8f65e12dc5339@mail.gmail.com>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com> 
	<1272232579-18895-2-git-send-email-wmpalmer@gmail.com> <1272232579-18895-3-git-send-email-wmpalmer@gmail.com> 
	<1272232579-18895-4-git-send-email-wmpalmer@gmail.com> <20100426072516.GA30416@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 10:15:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6JTd-0002v6-7u
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 10:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab0DZIP2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 04:15:28 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:39394 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab0DZIP0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 04:15:26 -0400
Received: by bwz19 with SMTP id 19so223848bwz.21
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 01:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Q5pZyMRYW2JVgZovqZaMn+SGKmNC2NhTqv3suSb7mzg=;
        b=aijgYaY5lDqlttXwQvBbusETipGBHHJL/Bu0bUpOXrPQc+1yN82LOcfT+oHe9sQVIb
         GUBApWTOh3IRcNLzIYV8iTkgtr2c+A47hbqt0JwZzdxKuCeu2rnJZtZpWG1kKsQqynxe
         4asuG4F67j1yja2gHLrF6IhK2/sHCw2DkrhyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vSCYdtXDKZH4lG8/ntsGMDRGQi7iv1iB1/mcAF/dk7XtANnZilpEq3vEU1Rwuch01p
         P+DHEGot0StboP3TH6tZ1Q4r+6OatIiH2Ghw9SaLHA8PQg8fHvpx6aKHFW9OHJQkcz82
         QpuRSe+E86LZ8cMMSwujTxI2g1jLeFBI9bEBo=
Received: by 10.103.78.31 with SMTP id f31mr1997938mul.79.1272269724211; Mon, 
	26 Apr 2010 01:15:24 -0700 (PDT)
Received: by 10.103.239.12 with HTTP; Mon, 26 Apr 2010 01:15:04 -0700 (PDT)
In-Reply-To: <20100426072516.GA30416@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145797>

I don't have time right now to reply line-by-line to this, so this is
just an ACK that it was
received, and I'll reply later today.


On Mon, Apr 26, 2010 at 8:25 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Will Palmer wrote:
>
>> format.pretty.<name>::
>> =A0 =A0 =A0 =A0Alias for a --pretty=3D format string, as specified i=
n
>> =A0 =A0 =A0 =A0linkgit:git-log[1]. Any aliases defined here can be u=
sed just
>> =A0 =A0 =A0 =A0as the builtin pretty formats could. For example, def=
ining
>> =A0 =A0 =A0 =A0"format.pretty.hash =3D format:%H" would cause the in=
vocation
>> =A0 =A0 =A0 =A0"git log --pretty=3Dhash" to be equivalent to running
>> =A0 =A0 =A0 =A0"git log --pretty=3Dformat:%H".
>
> Ah, so I could use
>
> =A0 =A0 =A0 =A0[format "pretty"]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wrapped =3D "format:\
> =A0 =A0 =A0 =A0%C(yellow)commit %H%n\
> =A0 =A0 =A0 =A0Merge: %p%n\
> =A0 =A0 =A0 =A0Author: %aN <%aE>%n\
> =A0 =A0 =A0 =A0Date: =A0 %ad%n%n%w(80,4,4)%s%n\
> =A0 =A0 =A0 =A0%+b"
>
> and then by default I get the standard medium, but with --format=3Dwr=
apped,
> I get my imitation of it. =A0Sounds very useful, thanks.
>
>> diff --git a/pretty.c b/pretty.c
>> index f884f48..d49fec7 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -11,6 +11,16 @@
>> =A0#include "reflog-walk.h"
>>
>> =A0static char *user_format;
>> +static struct cmt_fmt_map {
>> + =A0 =A0 const char *name;
>> + =A0 =A0 enum cmit_fmt format;
>> + =A0 =A0 const char *user_format;
>> + =A0 =A0 int is_tformat;
>> + =A0 =A0 int is_alias;
>> +} *commit_formats =3D NULL;
>> +static size_t commit_formats_len =3D 0;
>> +static size_t commit_formats_alloc =3D 0;
>> +static struct cmt_fmt_map *find_commit_format(const char *sought);
>>
>> =A0static void save_user_format(struct rev_info *rev, const char *cp=
, int is_tformat)
>> =A0{
>> @@ -21,22 +31,134 @@ static void save_user_format(struct rev_info *r=
ev, const char *cp, int is_tforma
>> =A0 =A0 =A0 rev->commit_format =3D CMIT_FMT_USERFORMAT;
>> =A0}
>>
>> -void get_commit_format(const char *arg, struct rev_info *rev)
>> +static int git_pretty_formats_config(const char *var, const char *v=
alue, void *cb)
>> +{
>> + =A0 =A0 if (!prefixcmp(var, "format.pretty.")) {
>
> Simpler to use
>
> =A0 =A0 =A0 =A0if (prefixcmp(var, "format.pretty."))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> to avoid keeping the reader in suspense.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cmt_fmt_map user_format =3D {0};
>> + =A0 =A0 =A0 =A0 =A0 =A0 const char *fmt;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 user_format.name =3D xstrdup(&var[14]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 user_format.format =3D CMIT_FMT_USERFORMAT=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 git_config_string(&fmt, var, value);
>
> git_config_string() does a strdup(), but we were about to either
> discard the value or do that ourselves anyway...
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!prefixcmp(fmt, "format:") || !prefixc=
mp(fmt, "tformat:")) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user_format.is_tformat =3D=
 fmt[0] =3D=3D 't';
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmt =3D strchr(fmt, ':') +=
 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (strchr(fmt, '%'))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user_format.is_tformat =3D=
 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user_format.is_alias =3D 1=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 user_format.user_format =3D fmt;
>
> ... or rather we would be, if this reused code from get_commit_format=
/
> save_user_format.
>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ALLOC_GROW(commit_formats, commit_formats_=
len+1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0commit_formats_allo=
c);
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&commit_formats[ commit_formats_len=
 ], &user_format,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(user_format));
>> + =A0 =A0 =A0 =A0 =A0 =A0 commit_formats_len++;
>
> Why not build it in place? =A0Not for performance reasons (that could=
 go
> either way); it is just that that would seem simpler to me.
>
>> + =A0 =A0 }
>> + =A0 =A0 return 0;
>> +}
>
> Regarding the next piece: I suspect the review would be easier if
> it had been more than one patch. =A0Maybe three patches:
>
> =A01 restructure get_commit_format to read from a (dynamic) list of
> =A0 supported formats that is not its responsibility
>
> =A02 infrastructure for format aliases (this is not needed for
> =A0 --format=3Ddatelist where datelist =3D "tformat:%h %cd")
>
> =A03 new configuration for user-defined formats and format aliases
>
> Maybe 3 could come before 2, since it seems like complicated.
>
> The new call graph looks like this:
>
> =A0setup_revisions() ->
> =A0 handle_revision_opt() ->
> =A0 get_commit_format() ->
> =A0 find_commit_format() ->
> =A0 setup_commit_formats() ->
> =A0 git_config() ->
> =A0 git_pretty_formats_config()
>
> This means we have to have searched for a repository before parsing
> these arguments; this constraint already exists for parsing the actua=
l
> revision arguments (maybe some day we will defer handling those
> arguments for some reason).
>
> I would have put the setup_commit_formats() call in setup_revisions()
> to make this more obvious, but I suppose this way you save time if no
> --format option is used.
>
>> +
>> +static void setup_commit_formats(void)
>> =A0{
>> =A0 =A0 =A0 int i;
>> - =A0 =A0 static struct cmt_fmt_map {
>> - =A0 =A0 =A0 =A0 =A0 =A0 const char *n;
>> - =A0 =A0 =A0 =A0 =A0 =A0 size_t cmp_len;
>> - =A0 =A0 =A0 =A0 =A0 =A0 enum cmit_fmt v;
>> - =A0 =A0 } cmt_fmts[] =3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 { "raw", =A0 =A0 =A0 =A01, =A0 =A0 =A0CMIT=
_FMT_RAW },
>> - =A0 =A0 =A0 =A0 =A0 =A0 { "medium", =A0 =A0 1, =A0 =A0 =A0CMIT_FMT=
_MEDIUM },
>> - =A0 =A0 =A0 =A0 =A0 =A0 { "short", =A0 =A0 =A01, =A0 =A0 =A0CMIT_F=
MT_SHORT },
>> - =A0 =A0 =A0 =A0 =A0 =A0 { "email", =A0 =A0 =A01, =A0 =A0 =A0CMIT_F=
MT_EMAIL },
>> - =A0 =A0 =A0 =A0 =A0 =A0 { "full", =A0 =A0 =A0 5, =A0 =A0 =A0CMIT_F=
MT_FULL },
>> - =A0 =A0 =A0 =A0 =A0 =A0 { "fuller", =A0 =A0 5, =A0 =A0 =A0CMIT_FMT=
_FULLER },
>> - =A0 =A0 =A0 =A0 =A0 =A0 { "oneline", =A0 =A01, =A0 =A0 =A0CMIT_FMT=
_ONELINE },
>> + =A0 =A0 const char **attempted_aliases =3D NULL;
>> + =A0 =A0 size_t attempted_aliases_alloc =3D 0;
>> + =A0 =A0 size_t attempted_aliases_len;
>> + =A0 =A0 struct cmt_fmt_map builtin_formats[] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 { "raw", =A0 =A0 =A0 =A0CMIT_FMT_RAW, =A0 =
=A0 =A0 =A0 =A0 NULL, =A0 0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { "medium", =A0 =A0 CMIT_FMT_MEDIUM, =A0 =A0=
 =A0 =A0NULL, =A0 0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { "short", =A0 =A0 =A0CMIT_FMT_SHORT, =A0 =
=A0 =A0 =A0 NULL, =A0 0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { "email", =A0 =A0 =A0CMIT_FMT_EMAIL, =A0 =
=A0 =A0 =A0 NULL, =A0 0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { "full", =A0 =A0 =A0 CMIT_FMT_FULL, =A0 =A0=
 =A0 =A0 =A0NULL, =A0 0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { "fuller", =A0 =A0 CMIT_FMT_FULLER, =A0 =A0=
 =A0 =A0NULL, =A0 0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { "oneline", =A0 =A0CMIT_FMT_ONELINE, =A0 =
=A0 =A0 NULL, =A0 1 }
>
> nitpick: Might be less noisy if the null format string field were the
> last field.
>
>> =A0 =A0 =A0 };
>> + =A0 =A0 commit_formats_len =3D ARRAY_SIZE(builtin_formats);
>> + =A0 =A0 ALLOC_GROW(commit_formats, commit_formats_len, commit_form=
ats_alloc);
>> + =A0 =A0 memcpy(commit_formats, builtin_formats,
>> + =A0 =A0 =A0 =A0 =A0 =A0sizeof(*builtin_formats)*ARRAY_SIZE(builtin=
_formats));
>> +
>> + =A0 =A0 git_config(git_pretty_formats_config, NULL);
>
> I suspect the body of the next loop should be its own function to kee=
p
> the reader=92s attention.
>
>> +
>> + =A0 =A0 for (i =3D ARRAY_SIZE(builtin_formats); i < commit_formats=
_len; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 attempted_aliases_len =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cmt_fmt_map *aliased_format =3D &co=
mmit_formats[i];
>> + =A0 =A0 =A0 =A0 =A0 =A0 const char *fmt =3D commit_formats[i].user=
_format;
>> + =A0 =A0 =A0 =A0 =A0 =A0 int j;
>
> declaration after statement
>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!commit_formats[i].is_alias)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 while ((aliased_format =3D find_commit_for=
mat(fmt))) {
> [...]
>
> Is this the right time to do this check? =A0Maybe we could check lazi=
ly
> when the format is used.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!aliased_format->is_al=
ias)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fmt =3D aliased_format->us=
er_format;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j=3D0; j<attempted_al=
iases_len; j++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcm=
p(fmt, attempted_aliases[j])) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 aliased_format =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Example:
>
> =A0 =A0 =A0 =A0[format "pretty"]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0foo =3D nonsense
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0one =3D foo
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0two =3D foo
>
> one is treated as an alias, but two is not. =A0Why?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!aliased_format)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> Is to escape from the wider loop? =A0I think this is a valid use for =
goto.
>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ALLOC_GROW(attempted_alias=
es, attempted_aliases_len+1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0att=
empted_aliases_alloc);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 attempted_aliases[attempte=
d_aliases_len] =3D fmt;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 attempted_aliases_len++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Example:
>
> =A0 =A0 =A0 =A0[format "pretty"]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0foo =3D medium
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xyzzy =3D one
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0one =3D foo
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0two =3D foo
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0frotz =3D two
>
> At the end of this loop, attempted_aliases contains:
>
> =A0 =A0 =A0 =A0one
> =A0 =A0 =A0 =A0foo
> =A0 =A0 =A0 =A0two
>
> Every alias which is itself referred to by an alias is listed.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (aliased_format) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 commit_formats[i].format =3D=
 aliased_format->format;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 commit_formats[i].user_for=
mat =3D aliased_format->user_format;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 commit_formats[i].is_tform=
at =3D aliased_format->is_tformat;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 commit_formats[i].is_alias=
 =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 commit_formats[i].format =3D=
 CMIT_FMT_UNSPECIFIED;
>> + =A0 =A0 }
>> +}
>
> Why go to the trouble to build attempted_aliases when it is never use=
d?
>
> I suspect I=92ve completely misunderstood, so I=92m stopping here. =A0=
Maybe
> someone else can clear it up or take over.
>
> Jonathan
>
