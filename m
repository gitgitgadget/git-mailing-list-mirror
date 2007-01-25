From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH/RFC] git-fetch: Only fetch in fetch
Date: Thu, 25 Jan 2007 01:52:50 +0100
Message-ID: <8aa486160701241652x375f0d0eoba1cdf3d14550034@mail.gmail.com>
References: <87veiwszpd.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 25 01:53:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9sru-00023E-6q
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 01:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933172AbXAYAx3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 24 Jan 2007 19:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933168AbXAYAx3
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 19:53:29 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:53311 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933172AbXAYAx2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jan 2007 19:53:28 -0500
Received: by wr-out-0506.google.com with SMTP id 68so319553wra
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 16:53:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qq3fsXllgAkCqaoq/SK6VgPeB966PcezBUSfE4Ak3LhJZ2PC+Ck6dWaPb4QtD8HlzrYKs8oYOeaJ6E0oG9emFOvnnNr2zwJsPPVYqvtQIZefQ8V2NZzaWmlMQFb2wkpxAFjejNP84puMEt24bFWsUarF4CPimE2A1oJbbLhZJ2E=
Received: by 10.78.164.13 with SMTP id m13mr1190836hue.1169686370353;
        Wed, 24 Jan 2007 16:52:50 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Wed, 24 Jan 2007 16:52:50 -0800 (PST)
In-Reply-To: <87veiwszpd.fsf@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37697>

On 1/25/07, Santi B=E9jar <sbejar@gmail.com> wrote:
>    I've tried to separate the fetch and merge logic. At the same time=
 it
>    has removed 40 lines of code to the git-*.sh.

Just some words for the basic idea.

git-fetch: fetches the branches from the remote and save this
information in .git/FETCH_HEAD. In .git/FETCH_REMOTE it save
additional information, as the remote nick, the remote url, the
refspec used and the default remote.

git-pull: uses this information to select the branches to merge and
save them in .git/FETCH_MERGE.

See you.

Santi
