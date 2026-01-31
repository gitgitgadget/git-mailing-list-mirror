Received: from mail-108-mta153.mxroute.com (mail-108-mta153.mxroute.com [136.175.108.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFEB1F0994
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769863150; cv=none; b=J4Hq30NkaLbu0UVstmW4U2s5sSS4Hd1dJOWs9HgBu/JSUHU4fVGyBrRDmarutSizeWZF65fa4J2IqJhFHOOFx5y4xsPzQ/qULOVwMZXqWJNiOt567TfO07S7T3vChON1b58rvY2BJ/00Ry5FeG0yfGdOP8fLC6BHDwo6rnR9nQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769863150; c=relaxed/simple;
	bh=hTvxHfllWFO7yRZr/Z+DP9+BmgZmsfD4W8TFy/SPEPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fn6Bv2ceSigmPmLy1iCTdKyM/GOVRyC5GwVMFouTfSaVI8zT3R5ZP2WUIDd3/APVGBeFOWc1Kde/NYao0MtRztPpgYYEShpOCq6sZCJ7N+cW/sBefK6VSLntA/HZtq7rlha/PS0+6VRafKlbNyFJmqqyURINHHFmh2WS6gyILJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me; spf=none smtp.mailfrom=ashlesh.me; dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b=rdj6p1pP; arc=none smtp.client-ip=136.175.108.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b="rdj6p1pP"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta153.mxroute.com (ZoneMTA) with ESMTPSA id 19c140ba74d0009140.003
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 12:33:53 +0000
X-Zone-Loop: 57330a162aeec01758b35343592a6be9912b950699f2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ashlesh.me;
	s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:
	To:Subject:MIME-Version:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=t4HFtw+LKSUg570Wil/Ds5HlMeW3G0JiLvnyUB2OaLs=; b=rdj6p1pPBQrrJrqWh08ce/gRKR
	B/N1vtI9o4sr/QTi5kOEDbGkspxrDk5D5HbJWQgGFqlQmZWr8y9HqTc8+ivBQSy1XPt3cBgdEcFao
	wwx/t4lJVLHnWBYCO5n8fTRvA/D8/4If/PK7rjUpbzd4bEe8Qk4ty4SAjwlS93UeFIGnvy/GjXZfE
	54sUMZbhdXAYFJuUN38KAOi6CT3wxN/TR50Br9MiI+szzJS1+OSe+g6cW66/TVm8MZiX6pSoYAWj8
	VSomZ6t0Y6IyD0hkrCxK4Grvdg1vQPvGe6enPOEYxq4qHBAXfkc+7RdIqHKdKHK0cB1hWb4GfQoUf
	8qYrXXRw==;
Message-ID: <49baf22b-ce7c-464c-8f6b-65ca7ed1e9f2@ashlesh.me>
Date: Sat, 31 Jan 2026 18:03:30 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] t5550: add netrc tests for http 401/403
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net, gitster@pobox.com
References: <20260106114029.763351-1-git@ashlesh.me>
 <20260107074724.13165-1-git@ashlesh.me>
Content-Language: en-US
From: Ashlesh Gawande <git@ashlesh.me>
In-Reply-To: <20260107074724.13165-1-git@ashlesh.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: info@ashlesh.me

Any other comments or suggestions on this patch that I can address?
(re-sending because the mailing list rejected my previous email for not 
being plain text).

Thanks
Ashlesh

On 1/7/26 13:17, Ashlesh Gawande wrote:
> git allows using .netrc file to supply credentials for HTTP auth.
> Three test cases are added in this patch to provide missing coverage
> when cloning over HTTP using .netrc file:
>
>    - First test case checks that the git clone is successful when credentials
>      are provided via .netrc file
>    - Second test case checks that the git clone fails when the .netrc file
>      provides invalid credentials. The HTTP server is expected to return
>      401 Unauthorized in such a case. The test checks that the user is
>      provided with a prompt for username/password on 401 to provide
>      the valid ones.
>    - Third test case checks that the git clone fails when the .netrc file
>      provides credentials that are valid but do not have permission for
>      this user. For example one may have multiple tokens in GitHub
>      and uses the one which was not authorized for cloning this repo.
>      In such a case the HTTP server returns 403 Forbidden.
>      For this test, the apache.conf is modified to return a 403
>      on finding a forbidden-user. No prompt for username/password is
>      expected after the 403 (unlike 401). This is because prompting may wipe
>      out existing credentials or conflict with custom credential helpers.
>
> Signed-off-by: Ashlesh Gawande <git@ashlesh.me>
> ---
> Range-diff against v2:
> 1:  0b68f1d1af ! 1:  25ef751f28 t5550: add netrc tests for http 401/403
>      @@ Metadata
>        ## Commit message ##
>           t5550: add netrc tests for http 401/403
>       
>      +    git allows using .netrc file to supply credentials for HTTP auth.
>      +    Three test cases are added in this patch to provide missing coverage
>      +    when cloning over HTTP using .netrc file:
>      +
>      +      - First test case checks that the git clone is successful when credentials
>      +        are provided via .netrc file
>      +      - Second test case checks that the git clone fails when the .netrc file
>      +        provides invalid credentials. The HTTP server is expected to return
>      +        401 Unauthorized in such a case. The test checks that the user is
>      +        provided with a prompt for username/password on 401 to provide
>      +        the valid ones.
>      +      - Third test case checks that the git clone fails when the .netrc file
>      +        provides credentials that are valid but do not have permission for
>      +        this user. For example one may have multiple tokens in GitHub
>      +        and uses the one which was not authorized for cloning this repo.
>      +        In such a case the HTTP server returns 403 Forbidden.
>      +        For this test, the apache.conf is modified to return a 403
>      +        on finding a forbidden-user. No prompt for username/password is
>      +        expected after the 403 (unlike 401). This is because prompting may wipe
>      +        out existing credentials or conflict with custom credential helpers.
>      +
>           Signed-off-by: Ashlesh Gawande <git@ashlesh.me>
>       
>        ## t/lib-httpd.sh ##
>
>   t/lib-httpd.sh             | 13 +++++++++++--
>   t/lib-httpd/apache.conf    |  4 ++++
>   t/lib-httpd/passwd         |  1 +
>   t/t5550-http-fetch-dumb.sh | 25 +++++++++++++++++++++++++
>   4 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index 5091db949b..5f42c311c2 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -319,13 +319,22 @@ setup_askpass_helper() {
>   	'
>   }
>   
> -set_askpass() {
> +set_askpass () {
>   	>"$TRASH_DIRECTORY/askpass-query" &&
>   	echo "$1" >"$TRASH_DIRECTORY/askpass-user" &&
>   	echo "$2" >"$TRASH_DIRECTORY/askpass-pass"
>   }
>   
> -expect_askpass() {
> +set_netrc () {
> +	# $HOME=$TRASH_DIRECTORY
> +	echo "machine $1 login $2 password $3" >"$TRASH_DIRECTORY/.netrc"
> +}
> +
> +clear_netrc () {
> +	rm -f "$TRASH_DIRECTORY/.netrc"
> +}
> +
> +expect_askpass () {
>   	dest=$HTTPD_DEST${3+/$3}
>   
>   	{
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index e631ab0eb5..6b8c50a51a 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -238,6 +238,10 @@ SSLEngine On
>   	AuthName "git-auth"
>   	AuthUserFile passwd
>   	Require valid-user
> +
> +	# return 403 for authenticated user: forbidden-user@host
> +	RewriteCond "%{REMOTE_USER}" "^forbidden-user@host"
> +	RewriteRule ^ - [F]
>   </Location>
>   
>   <LocationMatch "^/auth-push/.*/git-receive-pack$">
> diff --git a/t/lib-httpd/passwd b/t/lib-httpd/passwd
> index d9c122f348..3bab7b6423 100644
> --- a/t/lib-httpd/passwd
> +++ b/t/lib-httpd/passwd
> @@ -1 +1,2 @@
>   user@host:$apr1$LGPmCZWj$9vxEwj5Z5GzQLBMxp3mCx1
> +forbidden-user@host:$apr1$LGPmCZWj$9vxEwj5Z5GzQLBMxp3mCx1
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index ed0ad66fad..9530f01b9e 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -102,6 +102,31 @@ test_expect_success 'cloning password-protected repository can fail' '
>   	expect_askpass both wrong
>   '
>   
> +test_expect_success 'using credentials from netrc to clone successfully' '
> +	test_when_finished clear_netrc &&
> +	set_askpass wrong &&
> +	set_netrc 127.0.0.1 user@host pass@host &&
> +	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc &&
> +	expect_askpass none
> +'
> +
> +test_expect_success 'netrc unauthorized credentials (prompt after 401)' '
> +	test_when_finished clear_netrc &&
> +	set_askpass wrong &&
> +	set_netrc 127.0.0.1 user@host pass@wrong &&
> +	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-401 &&
> +	expect_askpass both wrong
> +'
> +
> +test_expect_success 'netrc authorized but forbidden credentials (fail on 403)' '
> +	test_when_finished clear_netrc &&
> +	set_askpass wrong &&
> +	set_netrc 127.0.0.1 forbidden-user@host pass@host &&
> +	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-403 2>err &&
> +	expect_askpass none &&
> +	grep "The requested URL returned error: 403" err
> +'
> +
>   test_expect_success 'http auth can use user/pass in URL' '
>   	set_askpass wrong &&
>   	git clone "$HTTPD_URL_USER_PASS/auth/dumb/repo.git" clone-auth-none &&
