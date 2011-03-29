From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: how to squash two commits into only one
Date: Tue, 29 Mar 2011 12:58:07 +0200
Message-ID: <AANLkTikX5YvMrooVi-7e-YDrCP_7QHqL6wR=1bY1cZ2L@mail.gmail.com>
References: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com>
 <AANLkTi=7TNjLVrcJVppiULBnDdKCM_vqwhn1JqoW+DQo@mail.gmail.com> <AANLkTimsN40twLwOWXsQqbv0SVN7T9rEHSUpcVum8aFR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lynn Lin <lynn.xin.lin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 12:58:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Wd8-0002Gc-Qm
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 12:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453Ab1C2K6a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 06:58:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56270 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab1C2K63 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 06:58:29 -0400
Received: by bwz15 with SMTP id 15so77296bwz.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 03:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=bH+S01fz40Pu7WfkvU3EIyWmcJR1DCQjxmvjbPOn2Xs=;
        b=iFzDNK54jaui6NbquSVwB2wvNK4ctyT2DwqtCWH6/oM2PI1R6K0H/+8eA99YSsN1Uu
         o9ep7ettsyAC+nKTSaf/mAdVkQp6n8m/WpC8e+bvhBB1PVU5dyYT/RO5D72m9nPrVI7E
         WLV4PiZvI51vmmSjP+6erEIFjtvM5td3FWCPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OYTzfe90W5PHtp740fJX0aVh4Nh64rAOulBarOIpKAMBuqUFkZSedW968aif/ixnx3
         h7CfM6nnvHfPgtCp6RCiA3HOUecM7ICVJF07B/n5HvvVMk7eAAm8PHJFeyD9s2jwiswo
         jB3noAF7mNRxH0IOEb5zJjDBODhjM4gEPL/HY=
Received: by 10.204.33.72 with SMTP id g8mr4621134bkd.3.1301396307258; Tue, 29
 Mar 2011 03:58:27 -0700 (PDT)
Received: by 10.204.29.2 with HTTP; Tue, 29 Mar 2011 03:58:07 -0700 (PDT)
In-Reply-To: <AANLkTimsN40twLwOWXsQqbv0SVN7T9rEHSUpcVum8aFR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170255>

On Tue, Mar 29, 2011 at 12:10, Lynn Lin <lynn.xin.lin@gmail.com> wrote:
> On Tue, Mar 29, 2011 at 5:38 PM, Alex Riesen <raa.lkml@gmail.com> wro=
te:
>> On Tue, Mar 29, 2011 at 07:42, Lynn Lin <lynn.xin.lin@gmail.com> wro=
te:
>>> All,
>>> =C2=A0 I have only have two commits in repo,then I want to squash t=
hese
>>> two commit into one through git rebase -i .However it fails
>>>
>>> $ git rebase -i HEAD^1
>>> it only show up one commit so can't squash (can't squash without a
>>> previous commit)
>>
>> $ git rebase -i HEAD~2
>>
> only have two commits

Uh. That's unusual.

Than yes, "git reset HEAD^; git commit --amend" seems the best solution=
=2E
