From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] git property page for project properties.
Date: Tue, 21 Oct 2008 19:50:50 +0200
Message-ID: <200810211950.50540.robin.rosenberg.lists@dewire.com>
References: <1224529604-42397-1-git-send-email-tomi.pakarinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, git@vger.kernel.org
To: Tomi Pakarinen <tomi.pakarinen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Oct 21 19:52:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsLOv-0002Sj-5N
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 19:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbYJURvA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Oct 2008 13:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbYJURvA
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 13:51:00 -0400
Received: from av7-2-sn3.vrr.skanova.net ([81.228.9.182]:60948 "EHLO
	av7-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbYJURu7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Oct 2008 13:50:59 -0400
Received: by av7-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id C6E6237E75; Tue, 21 Oct 2008 19:20:11 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av7-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 26A8237E55; Tue, 21 Oct 2008 19:20:10 +0200 (CEST)
Received: from sleipner.dewire.com (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id A37F537E44;
	Tue, 21 Oct 2008 19:50:56 +0200 (CEST)
Received: from dewire.com (unknown [10.9.0.1])
	by sleipner.dewire.com (Postfix) with ESMTP id BD5DE5AC;
	Tue, 21 Oct 2008 19:50:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 40A3E147EAE8;
	Tue, 21 Oct 2008 19:50:56 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 66nB3GmPq2uO; Tue, 21 Oct 2008 19:50:55 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id AC93D80284E;
	Tue, 21 Oct 2008 19:50:55 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1224529604-42397-1-git-send-email-tomi.pakarinen@iki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98799>

m=E5ndagen den 20 oktober 2008 21.06.44 skrev Tomi Pakarinen:
>  Show git property page in project's properties, if project
> has git repository provider.
[...]
> +		switch (repository.getRepositoryState()) {
> +		case BISECTING:
> +			state.setText("Bisecting");
> +			break;
> +		case MERGING:
> +			state.setText("Merging");
> +			break;
> +		case REBASING:
> +			state.setText("Rebasing");
> +			break;
> +		case REBASING_INTERACTIVE:
> +			state.setText("Rebasing interactive");
> +			break;
> +		case REBASING_MERGE:
> +			state.setText("Rebasing merge");
> +			break;
> +		case SAFE:
> +			state.setText("Safe");
> +			break;
> +		}
Why not this:

		state.setText(repository.getRepositoryState().getDescription());

Description is ment for presentation purposes. The enum for code.

-- robin
