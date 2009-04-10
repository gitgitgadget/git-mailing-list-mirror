From: Jacob Kaplan-Moss <jacob@jacobian.org>
Subject: Re: git-stash fails on OSX 10.5
Date: Fri, 10 Apr 2009 13:14:33 -0500
Message-ID: <be4ebbe10904101114w33c807d1je19b0c949e9a2009@mail.gmail.com>
References: <be4ebbe10904100944p6ec2c0dao8607fcff75d2754e@mail.gmail.com> 
	<7vy6u8whbp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 20:16:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsLHF-0005h1-1k
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 20:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939500AbZDJSOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 14:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939486AbZDJSOx
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 14:14:53 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:50195 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S939494AbZDJSOw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 14:14:52 -0400
Received: by qyk16 with SMTP id 16so2428740qyk.33
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=1qtwsJn2Q6MNznLWAowrc1wgwrc6oDAVgNncCvxkATw=;
        b=ukez/zIJEN5VyB+lhHWOammxoun7yy2NMCELxTM2jFzgp9r7fXb49CI3cj1e46y/lj
         Ij1siPYkr5U0CG9KLAg7+WwNAgGdhMUtlEV8gmQz1zPI+WyGOZisrZiICqQGNtK3BEOQ
         /8/yvHK3Tyh+0LCszF5nhrf8BwliphecYlQUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=Rv8hjkiOz6F6t6xTVUvU33TsnDZjLiek0Wqllcr9FGUaMLgakVaxo7aOAg9vp1xcmA
         9HXKi4rqGBnsS2aqkVepSPrdfpuHxBG4PG2+cPmjk4sM+3MNCbRMnjgCVS72RnP7h1oA
         PzP4GwdDPxg5MbPDEUdy58U5/Va6CtncrqQqk=
Received: by 10.220.75.199 with SMTP id z7mr5003694vcj.112.1239387289606; Fri, 
	10 Apr 2009 11:14:49 -0700 (PDT)
In-Reply-To: <7vy6u8whbp.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: d16d21b192e13333
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116270>

On Fri, Apr 10, 2009 at 12:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Otherwise the above error message wouldn't have said ".../.git/index"; it
> is coming from the only invocation of "cp" command in git-stash.sh

Sorry; I trimmed the error message to omit the details of where the
repository is since this happens regardless of the repo. The error
gives the full path to the file, i.e. "cp:
`/Users/jacob/Projects/uri/.git/index': No such file or directory".

Jacob
