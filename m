Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103F21359
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="PZ/WH+wC"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30466D53
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 08:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1699894232; x=1700499032; i=tboegi@web.de;
	bh=QwBjJDT26ucUV2giLaLB2TPZxCY7j38RApbyC3DMEaU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=PZ/WH+wC5AFbAd9STdmNksJOODala1biWQ/xNyp9BwG/0pURhlLxT7IeHcz8kOjy
	 KMYXkghog4Btp5X4GWnE6wWryts2qAv220KrnziaRA8jBJ6PGDoKk8qFQ0v2uxtYJ
	 GuUk2FjEEpDlD1n6/xWzwmZL4cuu5Ke1n44hU4vNWmcDQKUc8y9tRGfFEIanSa5Ei
	 TFFPUPcCfApMNo79jHGdtGxcfPZqpx2HaczbutfzyXuDwsgWWIXu9PrsnJHYuEfOO
	 d96GL625o7IgC123tc5TJZjD9sX4FlLOL4wKaN5DRv3h4PjfJ6syVpSB5Wb1GVQRV
	 OHOdOUgSvv4SxxqYNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjBRZ-1rYsUH1YKz-00f1bT; Mon, 13
 Nov 2023 17:50:32 +0100
Date: Mon, 13 Nov 2023 17:50:31 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] attr: add native file mode values support
Message-ID: <20231113165031.GA28778@tb-raspi4>
References: <20231111040309.2848560-1-jojwang@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231111040309.2848560-1-jojwang@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:jllZ4i5m71N52BCkFY84f73ebgumwfksvPs5mewejq9bHjEIMz5
 LgTX19e8l4LvNRSUuup6pZO0xc7DtoGZtZlWhPbc5jMIBBkkPiycCfCgFJOMvCy/2s8BYqI
 dK2tITyJkjMmt0RsyVYwCnMjaLG3JGmKgQcaqX3L+AebSJjS5jmaxp5z0cZdimCbTXT44ZX
 LKEgP6BfeXuth6zA/QDLQ==
UI-OutboundReport: notjunk:1;M01:P0:AXb749ah51A=;fLhYgJEY1gR/v3pmlGMoG4nrhsl
 4VxdUhg52A2xmqXP7858xBDXcB+xQnW27HL04ygEqclQrs8yA8pPDCZ9sJ64sYWjh3AU69aUM
 MEwvIJ/TNocx6bK9f2fRZNlLzEMV5/KkrSfoB0HZJeNyfsISBU7wkPdWOnp/P1nZrduMqphih
 VOmyTvj12VqWecC9RfwkC5CaEPktMNMOMvM4d3/W7Ks4gKtd0W6AnEbqXQutiosiWLjtBsAZi
 GQfEdag1aOhgjrSvZ1rF71mzINdqeAfx6RlmJo3Ho4nxmXu3Pw5JAqtSOvevH9QNf1e3TzXVd
 d/3ceyY3fMoqFWh3qolh6TT87gI2L6HiV2Z+UBf5nAeAYS5S8KYIsv1Y6Bs6rBHPKoH3MRMe7
 vKYiq5qLjzEUrPcgPkxQoHzdhUp51UDcfMgKIVj1H20v9aueHKvus5olTg26Cg48mnPS9075Z
 QU6Jo4vyHfcqjm5AmNwLc9vyB63ChFRV8Ig8KdmG75u2aBxttsB5NZcimzgCE9vrn1POxjMs2
 JlC44XKvlxcgTkT5BvfuBDH+BN+yxOo+jUGhFVEMYTJr1wMrzGwuQHYNna5xskZvRneE5ieT4
 N/ddvPqpAxdvwQ/u0l/czErZAIo3RLXaw9NVfnHtv1eQ4Iwb45HXI5oLxc8cqFeeZp+i/0fmq
 SdYY7oJ9790U1SfKVLCTtEsSw42rQQLAx8j1uekgmgW7+iiFaCpkjbB2Dlu6KT2NKsMsz3/Vd
 Q62C5gbOW8P+3XHg8CgDTw901p+KRNohX9hQcrFYVJ3gSHRgR1Yk1OWXodD6+fPnhTEsIX9UY
 5BME5U5LiE6f23Q6LnA3AA8jXAuatgpLDm1myIhrBJ7G5C3i/o+/+9utMn3/Y59PZby8wFQGT
 s65NtCZLGr8bo2jZPcOqlqZ8DHfy1FAG7h6QtrEfVY/uv3Zyn6rYIYX9yI72uW0AWkRuHQlM2
 91jfARL0XwcypiDnw5De5TO06AY=

On Sat, Nov 11, 2023 at 04:03:08AM +0000, Joanna Wang wrote:

Some thoughts and comments inline...

> Gives all paths inherent 'mode' attribute values based on the paths'
> modes (one of 100644, 100755, 120000, 040000, 160000). Users may use
> this feature to filter by file types. For example a pathspec such as
> ':(attr:mode=3D160000)' could filter for submodules without needing

My spontanous feeling is that filetype may be another choice:
> ':(attr:filetype=3D160000)' could filter for submodules without needing
And having written this, we can think using something borrowed from
`find . -type f`

:(attr:filetype=3Df)' or :(attr:filetype=3Dx)' (for executable)

> `mode=3D160000` to actually be specified for each subdmoule path in
> .gitattributes. The native mode values are also reflected in
> `git check-attr` results.

But then I missed the point why we need an attribute here?
The mode is already defined by the the file system (and Git),
is there a special reason that the user can define or re-define the
value here ?
May be there is, when working with pathspec.
But then "pathspec=3D" could be a better construction.
Since "mode" could make a reader think that Git does somewhat with the fil=
e
when checking out.
My personal hope reading "mode=3D100755" in .gitattributes would
be that Git makes it executable when checking out, if if it is
recorded in Git as 100644, probably coming from a file-system that
doesn't support the executable bit in a Unix way.


> If there is any existing mode attribute for a path (e.g. there is
> !mode, -mode, mode, mode=3D<value> in .gitattributes) that setting will
> take precedence over the native mode value.
>
> ---
>
> I went with 'mode' because that is the word used in documentation
> (e.g. https://git-scm.com/book/sv/v2/Git-Internals-Git-Objects)
> and in the code (e.g. `ce_mode`). Please let me know what you think
> of this UX.
>
> The implementation happens within git_check_attr() method which is
> the common mathod called for getting a pathspec attribute value.
>
> The previous discussed idea did not work with `git check-attr`.
> (https://lore.kernel.org/all/CAMmZTi8swsSMcLUcW+YwUDg8GcrY_ks2+i35-nsHE3=
o9MNpsUQ@mail.gmail.com/).
>
> There are no tests for excluding based on pathspec attrs in subdirectori=
es
> due to an existing bug. Since it is not specific to native mode, I thoug=
ht
> it would be better to fix separately.
> https://lore.kernel.org/all/CAMmZTi89Un+bsLXdEdYs44oT8eLNp8y=3DPm8ywaurc=
Q7ccRKGdQ@mail.gmail.com/

Reading "pathspec attrs" above it feels better to call the new attribute p=
athspec.
But why should a user be allowed to overwrite what we have in the index ?
That is somewhat missing in the motivation for this change,
it would be good to have this explained in the commit message.

>
>  Documentation/gitattributes.txt | 10 +++++++
>  attr.c                          | 42 ++++++++++++++++++++++++--
>  t/t0003-attributes.sh           | 40 +++++++++++++++++++++++++
>  t/t6135-pathspec-with-attrs.sh  | 53 +++++++++++++++++++++++++++++++++
>  4 files changed, 143 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribut=
es.txt
> index 8c1793c148..bb3c11f151 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -156,6 +156,16 @@ Unspecified::
>  Any other value causes Git to act as if `text` has been left
>  unspecified.
>
> +`mode`
> +^^^^^
> +
> +This attribute is for filtering files by their file bit modes
> +(40000, 120000, 160000, 100755, 100644) and has native support in git,
> +meaning values for this attribute are natively set (e.g. mode=3D100644)=
 by
> +git without having to specify them in .gitattributes. However, if
> +'mode' is set in .gitattributest for some path, that value takes precen=
dence,
> +whether it is 'set', 'unset', 'unspecified', or some other value.
> +
>  `eol`
>  ^^^^^
>
> diff --git a/attr.c b/attr.c
> index e62876dfd3..95dc1cf695 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -1240,20 +1240,58 @@ static struct object_id *default_attr_source(voi=
d)
>  	return &attr_source;
>  }
>
> +
> +/*
> + * This implements native file mode attr support.
> + * We always return the current mode of the path, not the mode stored
> + * in the index, unless the path is a directory where we check the inde=
x
> + * to see if it is a GITLINK. It is ok to rely on the index for GITLINK
> + * modes because a path cannot become a GITLINK (which is a git concept=
 only)
> + * without having it indexed with a GITLINK mode in git.
> + */
> +static unsigned int native_mode_attr(struct index_state *istate, const =
char *path)
> +{
> +	struct stat st;
> +	unsigned int mode;
> +	if (lstat(path, &st))
> +		die_errno(_("unable to stat '%s'"), path);
> +	mode =3D canon_mode(st.st_mode);
> +	if (S_ISDIR(mode)) {
> +		int pos =3D index_name_pos(istate, path, strlen(path));
> +		if (pos >=3D 0)
> +			if (S_ISGITLINK(istate->cache[pos]->ce_mode))
> +				return istate->cache[pos]->ce_mode;
> +	}
> +	return mode;
> +}
> +
> +
>  void git_check_attr(struct index_state *istate,
>  		    const char *path,
>  		    struct attr_check *check)
>  {
>  	int i;
>  	const struct object_id *tree_oid =3D default_attr_source();
> +	struct strbuf sb =3D STRBUF_INIT;
>
>  	collect_some_attrs(istate, tree_oid, path, check);
>
>  	for (i =3D 0; i < check->nr; i++) {
>  		unsigned int n =3D check->items[i].attr->attr_nr;
>  		const char *value =3D check->all_attrs[n].value;
> -		if (value =3D=3D ATTR__UNKNOWN)
> -			value =3D ATTR__UNSET;
> +		if (value =3D=3D ATTR__UNKNOWN){
> +			if (strcmp(check->all_attrs[n].attr->name, "mode") =3D=3D 0) {
> +				/*
> +				 * If value is ATTR_UNKNOWN then it has not been set
> +				 * anywhere with -mode (ATTR_FALSE), !mode (ATTR_UNSET),
> +				 * mode (ATTR_TRUE), or an explicit value. We fill
> +				 * value with the native mode value.
> +				 */
> +				strbuf_addf(&sb, "%06o", native_mode_attr(istate, path));
> +				value =3D sb.buf;
> +			} else
> +				value =3D ATTR__UNSET;
> +		}
>  		check->items[i].value =3D value;
>  	}
>  }
> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index aee2298f01..9c2603d8e2 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -19,6 +19,15 @@ attr_check () {
>  	test_must_be_empty err
>  }
>
> +attr_check_mode () {
> +	path=3D"$1" expect=3D"$2" git_opts=3D"$3" &&
It would be easier to read, if each assignment is on it's on line
> +
> +	git $git_opts check-attr mode -- "$path" >actual 2>err &&
> +	echo "$path: mode: $expect" >expect &&
> +	test_cmp expect actual &&
> +	test_must_be_empty err
> +}
> +
>  attr_check_quote () {
>  	path=3D"$1" quoted_path=3D"$2" expect=3D"$3" &&
>
> @@ -558,4 +567,35 @@ test_expect_success EXPENSIVE 'large attributes fil=
e ignored in index' '
>  	test_cmp expect err
>  '
>
> +test_expect_success 'submodule with .git file' '
> +	mkdir sub &&
> +	(cd sub &&
> +	git init &&
> +	mv .git .real &&
> +	echo "gitdir: .real" >.git &&
> +	test_commit first) &&
> +	git update-index --add -- sub

Style and indentation (Please use TAB for indenting)
Using sub-shells is good. Somewhat easier to read would be this:

	mkdir sub &&
	(
	  cd sub &&
	  git init &&
	  mv .git .real &&
	  echo "gitdir: .real" >.git &&
	  test_commit first
	)  &&




> +'
> +
> +test_expect_success 'native mode attributes work' '
> +	>exec && chmod +x exec && attr_check_mode exec 100755 &&
> +	>normal && attr_check_mode normal 100644 &&
> +	mkdir dir && attr_check_mode dir 040000 &&
> +	ln -s normal normal_sym && attr_check_mode normal_sym 120000 &&
> +	attr_check_mode sub 160000
> +'

We need a precondition here:
test_expect_success SYMLINKS

> +
> +test_expect_success '.gitattributes mode values take precedence' '
> +	(
> +		echo "mode_value* mode=3Dmyownmode" &&
> +		echo "mode_set* mode" &&
> +		echo "mode_unset* -mode" &&
> +		echo "mode_unspecified* !mode"
> +	) >.gitattributes &&

Can this be written using a
	cat <<-\EOF >expect &&

	EOF
expression ?

> +	>mode_value && attr_check_mode mode_value myownmode &&
> +	>mode_unset && attr_check_mode mode_unset unset &&
> +	>mode_unspecified && attr_check_mode mode_unspecified unspecified &&
> +	>mode_set && attr_check_mode mode_set set
> +'
> +
>  test_done
> diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attr=
s.sh
> index a9c1e4e0ec..fd9569d39b 100755
> --- a/t/t6135-pathspec-with-attrs.sh
> +++ b/t/t6135-pathspec-with-attrs.sh
> @@ -64,6 +64,9 @@ test_expect_success 'setup .gitattributes' '
>  	fileSetLabel label
>  	fileValue label=3Dfoo
>  	fileWrongLabel label=E2=98=BA
> +	mode_set* mode=3D1234
> +	mode_unset* -mode
> +	mode_unspecified* !mode
>  	EOF
>  	echo fileSetLabel label1 >sub/.gitattributes &&
>  	git add .gitattributes sub/.gitattributes &&
> @@ -295,4 +298,54 @@ test_expect_success 'reading from .gitattributes in=
 a subdirectory (3)' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'mode attr is handled correctly for overriden value=
s' '
> +	>mode_set_1 &&
> +	>mode_unset_1 &&
> +	>mode_unspecified_1 &&
> +	>mode_regular_file_1 &&
> +
> +	git status -s ":(attr:mode=3D1234)mode*" >actual &&
> +	cat <<-\EOF >expect &&
> +	?? mode_set_1
> +	EOF
> +	test_cmp expect actual &&
> +
> +	git status -s ":(attr:-mode)mode*" >actual &&
> +	echo ?? mode_unset_1 >expect &&
> +	test_cmp expect actual &&
> +
> +	git status -s ":(attr:!mode)mode*" >actual &&
> +	echo ?? mode_unspecified_1 >expect &&
> +	test_cmp expect actual &&
> +
> +	git status -s ":(attr:mode=3D100644)mode*" >actual &&
> +	echo ?? mode_regular_file_1 >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'mode attr values are current file modes, not index=
ed modes' '
> +	>mode_exec_file_1 &&
> +
> +	git status -s ":(attr:mode=3D100644)mode_exec_*" >actual &&
> +	echo ?? mode_exec_file_1 >expect &&
> +	test_cmp expect actual &&
> +
> +	git add mode_exec_file_1 && chmod +x mode_exec_file_1 &&
> +	git status -s ":(attr:mode=3D100755)mode_exec_*" >actual &&
> +	echo AM mode_exec_file_1 >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'mode attr can be excluded' '
> +	>mode_1_regular &&
> +	>mode_1_exec  && chmod +x mode_1_exec &&
> +	git status -s ":(exclude,attr:mode=3D100644)" "mode_1_*" >actual &&
> +	echo ?? mode_1_exec >expect &&
> +	test_cmp expect actual &&
> +
> +	git status -s ":(exclude,attr:mode=3D100755)" "mode_1_*" >actual &&
> +	echo ?? mode_1_regular >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.42.0.869.gea05f2083d-goog
>
>
