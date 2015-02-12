From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 3/3] transport-helper: fix typo in error message when
 --signed is not supported
Date: Thu, 12 Feb 2015 19:20:48 +0900
Message-ID: <20150212102048.GA25303@glandium.org>
References: <1423735801-11108-1-git-send-email-mh@glandium.org>
 <1423735801-11108-3-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 11:21:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLqtT-0004M8-8Q
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 11:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbbBLKU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 05:20:59 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:48195 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755220AbbBLKU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 05:20:56 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YLqt6-0006bl-AT; Thu, 12 Feb 2015 19:20:48 +0900
Content-Disposition: inline
In-Reply-To: <1423735801-11108-3-git-send-email-mh@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263715>

On Thu, Feb 12, 2015 at 07:10:01PM +0900, Mike Hommey wrote:
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  transport-helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/transport-helper.c b/transport-helper.c
> index c3868e4..b72fd4a 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -861,7 +861,7 @@ static int push_refs_with_export(struct transport *transport,
>  			die("helper %s does not support dry-run", data->name);
>  	} else if (flags & TRANSPORT_PUSH_CERT) {
>  		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "true") != 0)

Note that this TRANS_OPT_PUSH_CERT option is not documented in
Documentation/gitremote-helpers.txt.

Mike
