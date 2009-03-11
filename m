From: Miles Bader <miles@gnu.org>
Subject: Re: setting up tracking on push
Date: Wed, 11 Mar 2009 13:56:52 +0900
Message-ID: <fc339e4a0903102156q4b61b712j6c7b4daaef6f163@mail.gmail.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
	 <buoy6vi297q.fsf@dhlpc061.dev.necel.com>
	 <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>
	 <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com>
	 <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com>
	 <20090310230939.GB14083@sigio.peff.net>
	 <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com>
	 <20090311020409.GA31365@coredump.intra.peff.net>
	 <7vwsaw7jzy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 05:58:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhGWO-0004MM-L2
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 05:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbZCKE44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 00:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbZCKE44
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 00:56:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:19420 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbZCKE4z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 00:56:55 -0400
Received: by nf-out-0910.google.com with SMTP id d21so387838nfb.21
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 21:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=a8tcZLpIqDeGJptibKK1KWQLOKEJbi1nNcjYuQERPFs=;
        b=sUh8xG38G7UTSQ4s7ZymOkr/UwLybH1wHFquinlCdyhXyoSjWzxpU2TsB0XnT8acPU
         ZO0upH068ay9V0aseslUeN61sVAonxc/Dfpk59tOJns4oQEs/Dt5kVQfRuU39XSK+Dv2
         dL0QNjxlIYZps1lVGQ6pNdzxcD4/LSxkHeTbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=W0JOEtG4X8EYt685HfurmGRzkHbDQezWUuqBSZdBL2+NKYqNBEyfVdrsTwGLQA+x/i
         JrANBhWpZds1sFZNheD6LX/jEvq9Q0V3/bFALpZqSFLN31wkRydhfqLKNvPu1i+A9Sye
         NAVymsh/qJj6W6G/46igOo4m+25o2U0OcfKsM=
Received: by 10.216.19.68 with SMTP id m46mr3202196wem.7.1236747412453; Tue, 
	10 Mar 2009 21:56:52 -0700 (PDT)
In-Reply-To: <7vwsaw7jzy.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: 1c9a59965988b7fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112882>

On Wed, Mar 11, 2009 at 1:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> And for that use case, I find it sensible if we had a way to easily say
> "This branch hasn't been tracking anything so far (because it is the
> originator of the history), but now it will give up its authority and
> start tracking the one it is pushing into", and it would make sense to
> somehow link that to the invocation of "git push".

I agree, and that's the use-case that prompted my original query.  I
very often create a new branch locally, and later push it to origin
with an intent to subsequently keep it synced with the new remote
branch.

-Miles

-- 
Do not taunt Happy Fun Ball.
