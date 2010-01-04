From: Sebastian Thiel <byronimo@googlemail.com>
Subject: Re: [PATCH] git-update-index: report(...) now flushes stdout after 
	printing the report line
Date: Mon, 4 Jan 2010 11:30:16 +0100
Message-ID: <ba5802b21001040230ud27c06bw3531724862cb12c4@mail.gmail.com>
References: <loom.20091119T221732-624@post.gmane.org>
	 <loom.20100103T114055-16@post.gmane.org>
	 <be6fef0d1001031503h11cb65c6ha34eee345b9b7055@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Jan 04 11:30:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRkCu-00014v-Iv
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 11:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158Ab0ADKaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 05:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923Ab0ADKaT
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 05:30:19 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:63279 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab0ADKaS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 05:30:18 -0500
Received: by bwz27 with SMTP id 27so9146078bwz.21
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 02:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:cc:content-type;
        bh=v69iawOMvktlA88ub38fiNvHsVtfYaTqN6f3hUCH7Oc=;
        b=KMQBG2pBZUiscr4WorJLdeaLl3PEhXJTR+NtyNrL+/yNtargfqoPutJEHnGonHyue2
         726igItraJB7cvFmkbv45OLqU+Uz1SQXHvaDAXEBfIW3Z99BKy3gNqb91yzOrkXlDyo2
         YaBL1b1Piw1Hw//cSj2rwQth/vNzmx/XO3mQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:cc
         :content-type;
        b=vYnNLINQ3qNZW5/Gh+cPTVuND6p2vEc1ybZcsXF2xDaLbewoYwn+QONPBLurcwnBxx
         EptN+sTH1uPXrVuLJOmm8WuX4pKS//DBYFcyE5ITr6liGhsAD7UPET3ddJ528WOhTKcp
         TyeOg2yGFkq+0zgzthPB6UVdguUSyXGiBJGGo=
Received: by 10.204.153.27 with SMTP id i27mr10772678bkw.155.1262601016586; 
	Mon, 04 Jan 2010 02:30:16 -0800 (PST)
In-Reply-To: <be6fef0d1001031503h11cb65c6ha34eee345b9b7055@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136106>

Thanks Ray Chuan, for the clarification, the progress is supposed to
be sent in git-push and git-fetch ( not git-pull as I mentioned ).
A --progress flag would already do it for me, is there a way to fetch
your code from somewhere for a test run ?

When do you think will your changes be available for a mainline merge,
or would it even be possible to separate the --progress adjustment
from your feature to merge it into mainline individually ?

Thanks,
Sebastian
