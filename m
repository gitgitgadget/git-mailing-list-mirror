From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: use "command-line" when used as a compound adjective, and fix other minor grammatical issues
Date: Wed, 21 May 2014 12:06:28 -0700
Message-ID: <xmqqk39fossr.fsf@gitster.dls.corp.google.com>
References: <1400698346-25949-1-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Wed May 21 21:06:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnBqY-0008Ib-Db
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 21:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbaEUTGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 15:06:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53966 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853AbaEUTGe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 15:06:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 789E318CA3;
	Wed, 21 May 2014 15:06:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PM49lg7CVNCmEPRkOT3mtZzFnpM=; b=CUVZZy
	mc9LJIh08kv4CXpcFZYQThAvOKvkyH/Mf3FsCprKb1WJ9V0zXPlclAeFnXp+/o1Y
	+y1VuQclFCa+xMDv2/oKax1fGh0fSVH1F69HZGWFy6gJqgtYpP5BMJoB6yw3jUD9
	zk9QlzTmLQME233paxOaP6PLGjHW7WSMt6L4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hWu9dRIkNYIEd86weuMvJ5f/TjOOYc9B
	yRd0pyqr0tIENSW4AK/kimrKhln1nRm6uRQOJgB5aBenDJ456r6hMwCaeW25HCar
	AmkukhQeBQ7+fbHnc0SU8qSiaO2Pb8HHil385AHcCLz1jRdIftJTxgrD/N92acfX
	Us9cRPtgLlw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6EAB418CA0;
	Wed, 21 May 2014 15:06:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C80918C98;
	Wed, 21 May 2014 15:06:30 -0400 (EDT)
In-Reply-To: <1400698346-25949-1-git-send-email-jstjohn@purdue.edu> (Jason
	St. John's message of "Wed, 21 May 2014 14:52:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 044E8E60-E11B-11E3-B272-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249825>

"Jason St. John" <jstjohn@purdue.edu> writes:

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 022e74e..01200ed 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -173,13 +173,13 @@ index 65898fa..b002dc6 100644
>  --- a/init-db.c
>  +++ b/init-db.c
>  @@ -7,7 +7,7 @@
> - 
> +
>   int main(int argc, char **argv)
>   {
>  -	char *sha1_dir = getenv(DB_ENVIRONMENT), *path;
>  +	char *sha1_dir, *path;
>   	int len, i;
> - 
> +
>   	if (mkdir(".git", 0755) < 0) {
>  ------------------------------------------------

I know it would not make any difference either way when printed, but
aren't we showing how a typical diff output looks like with this
example, and each of these two otherwise blank lines should actually
be a line with a single SP on it?

Everything else looked fine.  Thanks for cleaning the docs up.
