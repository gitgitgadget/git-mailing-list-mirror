Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97930C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 21:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709B261391
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 21:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhHWVER (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 17:04:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:52603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232503AbhHWVEN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 17:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629752574;
        bh=xoe1llePkN8LheKYtyRWxuuGOcmm9tTQZ1q4UHe2L94=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=C9d1CoVDwI+DV7qhHPVY0rJgv/I+AXmIjtZwLST9LNG60HD7AiZk6h9jsDqnypxfg
         mVmnEXJ26PU16Nhk+Yvq3NNnQpD+71qhfvXJzVkQs2EtuKlVQ8tq5Aqy8DdEi6j/h0
         l06Tdg9FJaRks/0wZmuwbRoIpTOaWOVQJvQNWrp4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbkM-1mb1rW1Ejs-00L19X; Mon, 23
 Aug 2021 23:02:54 +0200
Date:   Mon, 23 Aug 2021 23:02:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?Q?Tr=E1=BA=A7n_Ng=E1=BB=8Dc_Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/1] ci: new github-action for git-l10n code review
In-Reply-To: <20210822161325.22038-2-worldhello.net@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108232232460.55@tvgsbejvaqbjf.bet>
References: <20210822161325.22038-1-worldhello.net@gmail.com> <20210822161325.22038-2-worldhello.net@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:R2BwvCfLutSCIRmhnFdSbt0qbMY+Ry4HaDedWq1Ni+xCBARGNFj
 qMf2tkBNs0TtauZva1tw+5YyqDJ52yd3N3asOMsbjeI9PI+8H9J5tSYJisIeQ42J9lexABR
 l+SHH95eodiYV1u0mk8af7xwug8S+PrBAzm9rsT+NCeDLMuALTuR0E0QqzHU/Ho7QP5kp0t
 zdG7nR6KLDt5+wEriT0UA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JHihqEmLccM=:es4EqH7yBjw5qdmCKzC052
 voSuvoUUDHtxUDg0DvJWAlrcsxEVvkVYNLufWH1+ntTI2SEfkKGrO7kOe2/wDXM5zg3ZXt2Mh
 Ds6Mn7A1f8N7sfEA4KuqWXqRwR0YQjzyAyOHofdqxkhVzaLh2MFPBTXiGnAADWu9aDsWPx8ax
 i/RSs/9TLzP8NfACv7+j9UWgXm11j6nBvXgHXHmbNohej4VocxI3yKbtPrhCsMuXB3RK2Pu+n
 Xqf5CjKF1FYZTlHo1asn3QL/hezqL5pVsT/A1E4v2E3Ji8v3/bNvIHGrHbJQ3229vb4BXwaKw
 cR5mOm11V/NMjex7p5zHqmnbgwI5M9QVnnSOgp13oWZmWhdFNpCnfAxI9UdBqfyvC8FVrl9Ac
 O87HtWh8lCp5IUnUNI8uJNGIAydK23/X+Xt/RIWOGCnGR2cK6PI1nSUQUK3JO1cr4e483Xhod
 9jt9EEzTJAjmD3+jGRG/NtPCNXtmpgGGU9Ll2odSCX7yRNcy2ksQK+BgPIH3NNqJ/coUEgBM/
 HF5NUDQCRGeZl8cJ/Z89r0CjHx4vBjPSMDmxdCRTv8cwlci8uZJnrKVNTnPJVFH85sAPLYbQj
 /s9Pwhyr+a3lkEIMHisfyIcP/CycoOeH7pCjs+7J4mkVqCJ0+vQbpmw/oqu+sOqsDNszPpweV
 +n2xzbsnZK0UYmbw6E2C7iQ1+5g2Uldy5/fEhh0TjebXAO0cOEou81fd8Br3/vqQgUhld0juW
 eodBWyDTJX4GXpZ6WQlu8i6mrVJik4Z0oN80ZMphnGsyb3sPhhSFiMiEpeMGHXmhsUCo7Tzg4
 VkmaE/4zDPIPgmRO4MpJZ4NXdpI0vMUXTftpx2Tl69wV1XwrL+b0tlObgI9I1Tpyojp96HnVh
 ++Jfl3Dai5y80KhqVjzYE/tkfTVWRRhgBti4SOYovlI/EK7igpFXisJyUdEGD5keqcFKeW8GC
 QmKM3Dnz4TArBSvuXe9AiOCs9Hv3WTBNAmA1NOgAOVQEuVSWvhoF6e/l1Ng8TYELkbxfUlcWX
 7RLWpVybsmAnBs5lAH6Dcjv5XlCcWc7urs4Hhpafe4Pu1iNO6kjapzdsd2oTqPVLDgtr5zxbg
 PFW0+XyNBE0mCkN9njZW5hQQHw5ZXveBXVH0ke/VFyp2ozQw2xdMyzRbg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 23 Aug 2021, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Git l10n uses github pull request for code review. A helper program
> "git-po-helper" can be used to check typos in ".po" files, validate
> syntax, and check commit message. It would be convenient to integrate
> this helper program to CI and add comments in pull request.
>
> The new github-action workflow is added in ".github/workflows/l10n.yml",
> which is disabled by default. To turn it on for the git-l10n related
> repositories, such as "git-l10n/git-po", we can add a new branch named
> "ci-config" and create a simple shell script at "ci/config/allow-l10n"
> in this branch.
>
> The new l10n workflow listens to two types of github events: push and
> pull_request.
>
> For a push event, it will scan commits one by one. If a commit does not
> look like a l10n commit (no file in "po/" has been changed), it will
> immediately fail without checking for further commits. While for a
> pull_request event, all new introduced commits will be scanned.
>
> "git-po-helper" will generate two kinds of suggestions, errors and
> warnings. A l10n contributor should try to fix all the errors, and
> should pay attention to the warnings. All the errors and warnings will
> be reported in the last step of the l10n workflow as two message groups.
> For a pull_request event, will create additional comments in pull
> request to report the result.

It is a good idea to automate this.

I am a bit concerned that the `ci-config` approach, even if we use it in
the Git project itself, is quite cumbersome to use, though. So I hope that
we can find an alternative solution.

One such solution could be to make the `git-po-helper` job contingent on
part of the repository name. For example:

  git-po-helper:
    if: endsWith(github.repository, '/git-po')
    [...]

would skip the job unless the target repository's name is `git-po`.

A couple more questions/suggestions are below:

> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  .github/workflows/l10n.yml | 143 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 .github/workflows/l10n.yml
>
> diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
> new file mode 100644
> index 0000000000..60f162c121
> --- /dev/null
> +++ b/.github/workflows/l10n.yml
> @@ -0,0 +1,143 @@
> +name: git-l10n
> +
> +on: [push, pull_request]
> +
> +jobs:
> +  ci-config:
> +    runs-on: ubuntu-latest
> +    outputs:
> +      enabled: ${{ steps.check-l10n.outputs.enabled }}
> +    steps:
> +      - name: try to clone ci-config branch
> +        run: |
> +          git -c protocol.version=3D2 clone \
> +            --no-tags \
> +            --single-branch \
> +            -b ci-config \
> +            --depth 1 \
> +            --no-checkout \
> +            --filter=3Dblob:none \
> +            https://github.com/${{ github.repository }} \
> +            config-repo &&
> +          cd config-repo &&
> +          git checkout HEAD -- ci/config || : ignore
> +      - id: check-l10n
> +        name: check whether CI is enabled for l10n
> +        run: |
> +          enabled=3Dno
> +          if test -x config-repo/ci/config/allow-l10n &&
> +             config-repo/ci/config/allow-l10n '${{ github.ref }}'
> +          then
> +            enabled=3Dyes
> +          fi
> +          echo "::set-output name=3Denabled::$enabled"
> +
> +  git-po-helper:
> +    needs: ci-config
> +    if: needs.ci-config.outputs.enabled =3D=3D 'yes'
> +    runs-on: ubuntu-latest
> +    steps:
> +    - uses: actions/checkout@v2
> +      with:
> +        fetch-depth: '0'

There is code below to specifically fetch the base commit, but setting the
`fetch-depth` to zero means to do a full clone anyway.

So maybe the `git fetch` code below should be dropped, or the
`fetch-depth` override?

Since we cannot know how deep we need to fetch, though, I figure that it
would be indeed better to have a non-shallow clone (and a code comment
would help clarify this).

An even better alternative would be a partial clone, of course, but I fear
that there is no convenient way yet to configure `actions/checkout` to do
so.

> +    - uses: actions/setup-go@v2
> +      with:
> +        go-version: ">=3D1.16"
> +    - name: Install git-po-helper
> +      run: |

Since this is a one-liner, it would probably make sense to avoid that `|`
continuation.

> +        go install github.com/git-l10n/git-po-helper@main
> +    - name: Install other dependencies
> +      run: |
> +        sudo apt-get update -q &&
> +        sudo apt-get install -q -y gettext
> +    - id: check-commits
> +      name: Run git-po-helper
> +      run: |
> +        if test "${{ github.event_name }}" =3D "pull_request"
> +        then
> +          commit_from=3D${{ github.event.pull_request.base.sha }}
> +          commit_to=3D${{ github.event.pull_request.head.sha }}
> +        else
> +          commit_from=3D${{ github.event.before }}
> +          commit_to=3D${{ github.event.after }}
> +          if ! echo $commit_from | grep -q "^00*$"

This would probably read better as:

		case "$commit_from" in
		*[^0]*|'') ;; # not all zeros
		*)
			[...]
			;;
		esac

But we might not need it anyway. See the comment on the `git fetch`
command below.

> +          then
> +            if ! git rev-parse "$commit_from^{commit}"
> +            then
> +              git fetch origin $commit_from

As pointed out above, we cannot know how many commits we need to fetch.
Therefore, I would suggest to simply drop this `git fetch`.

> +            fi
> +          fi
> +        fi
> +        exit_code=3D0
> +        git-po-helper check-commits --github-action -- \
> +          $commit_from..$commit_to >git-po-helper.out 2>&1 ||

What does the `--github-action` option do? Might be good to document this
here.

> +        exit_code=3D$?
> +        echo "::set-output name=3Dexit_code::$exit_code"
> +        has_error_msg=3D
> +        has_warning_msg=3D
> +        if test $exit_code -ne 0
> +        then
> +          has_error_msg=3Dyes

Do we really need this `has_error_msg` variable? It would be much easier
to test the condition `env.ERROR_MSG !=3D ''` in subsequent steps, and tha=
t
would already do the job, without having to go through output variables.

> +          if test "${{ github.event_name }}" =3D "pull_request"
> +          then
> +            echo "ERROR_MSG<<EOF" >>$GITHUB_ENV
> +            grep -v -e "^level=3Dwarning" -e WARNING git-po-helper.out =
|
> +              perl -pe 's/\e\[[0-9;]*m//g' >>$GITHUB_ENV

This is a bit dangerous. First of all, how can you be sure that
`git-po-helper.out` does not contain lines that consist of the letters
`EOF` (and would therefore interfere with the here-doc)?

Second, isn't it conceivable to have an `error:` line which contains the
characters `WARNING` too? That line would be filtered out...

Third, can `git-po-helper` be convinced _not_ to print color codes? The
output was redirected into a file, after all, and it does not go to a
terminal...

> +            echo "EOF" >>$GITHUB_ENV
> +          fi
> +        fi
> +        if grep -q -e "^level=3Dwarning" -e WARNING git-po-helper.out
> +        then
> +          has_warning_msg=3Dyes
> +          if test "${{ github.event_name }}" =3D "pull_request"
> +          then
> +            echo "WARNING_MSG<<EOF" >>$GITHUB_ENV
> +            grep -v -e "^level=3Derror" -e ERROR git-po-helper.out |
> +              perl -pe 's/\e\[[0-9;]*m//g' >>$GITHUB_ENV
> +            echo "EOF" >>$GITHUB_ENV
> +          fi
> +        fi
> +        echo "::set-output name=3Dhas_error_msg::$has_error_msg"
> +        echo "::set-output name=3Dhas_warning_msg::$has_warning_msg"
> +    - name: Report errors in comment for pull request
> +      uses: mshick/add-pr-comment@v1
> +      if: steps.check-commits.outputs.has_error_msg =3D=3D 'yes' && git=
hub.event_name =3D=3D 'pull_request'
> +      continue-on-error: true
> +      with:
> +        repo-token: ${{ secrets.GITHUB_TOKEN }}

This requires the `GITHUB_TOKEN` to have write permissions, which I would
highly recommend not to require.

Instead, it would probably make more sense to keep the output in the logs
of the workflow run.

> +        repo-token-user-login: 'github-actions[bot]'
> +        message: |
> +          Errors found by git-po-helper in workflow ${{ github.workflow=
 }}:
> +          ```
> +          ${{ env.ERROR_MSG }}
> +          ```
> +    - name: Report warnings in comment for pull request
> +      uses: mshick/add-pr-comment@v1
> +      if: steps.check-commits.outputs.has_warning_msg =3D=3D 'yes' && g=
ithub.event_name =3D=3D 'pull_request'
> +      continue-on-error: true
> +      with:
> +        repo-token: ${{ secrets.GITHUB_TOKEN }}
> +        repo-token-user-login: 'github-actions[bot]'
> +        message: |
> +          Warnings found by git-po-helper in workflow ${{ github.workfl=
ow }}:
> +          ```
> +          ${{ env.WARNING_MSG }}
> +          ```
> +    - name: Report and quit
> +      run: |
> +        if test "${{ steps.check-commits.outputs.has_error_msg }}" =3D =
"yes"

This would be easier to read and maintain if it was upgraded to an `if:`
condition:

    - name: Report errors
      if: step.check-commits.outputs.has_error_msg =3D "yes"
      run: |
        [...]

And then do the same for warnings.

Also, it would be more natural if the `Run git-po-helper` step was allowed
to fail when `git-po-helper` outputs errors. You would then have to use
this conditional in the `Report errors` step:

      if: failure() && step.check-commits.outputs.has_error_msg =3D "yes"

(compare to how Git's `CI/PR` workflow prints errors:
https://github.com/git/git/blob/v2.33.0/.github/workflows/main.yml#L120).

For the `Report warnings` step, you would however have to use something
slightly less intuitive:

      if: (success() || failure()) && step.check-commits.outputs.has_warni=
ng_msg =3D "yes"

Finally, I _do_ think that this line would be easier to read like this,
while basically doing the same thing but with less effort (because the
outputs would no longer have to be set):

      if: (success() || failure()) && env.WARNING_MSG !=3D ""

Ciao,
Dscho

> +        then
> +          echo "::group::Errors found by git-po-helper"
> +          grep -v -e "^level=3Dwarning" -e WARNING git-po-helper.out
> +          echo "::endgroup::"
> +        fi
> +        if test "${{ steps.check-commits.outputs.has_warning_msg }}" =
=3D "yes"
> +        then
> +          echo "::group::Warnings found by git-po-helper"
> +          grep -v -e "^level=3Derror" -e ERROR git-po-helper.out
> +          echo "::endgroup::"
> +        fi
> +        if test ${{ steps.check-commits.outputs.exit_code }} -ne 0
> +        then
> +          exit ${{ steps.check-commits.outputs.exit_code }}
> +        fi
> --
> 2.33.0
>
>
