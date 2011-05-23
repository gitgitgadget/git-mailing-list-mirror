From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [git-p4] Trouble importing all perforce branches into git repository
Date: Mon, 23 May 2011 18:38:03 +0100
Message-ID: <BANLkTik+Zp1Fvi_zABCtAZH0RKA68n5Svw@mail.gmail.com>
References: <20110522114917.GA19927@arf.padd.com> <398FA881-E4A1-49AC-80F2-2D46E9F2ABB9@gmail.com>
 <BANLkTi=TCyyS7Q=3BnLcG=yhL_boH=w1XA@mail.gmail.com> <34E33A18-B9C4-4CA9-B96C-79B0E2BDCD44@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Grant Limberg <glimberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 19:38:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOZ5U-0002sN-IE
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 19:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355Ab1EWRig convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 13:38:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58410 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167Ab1EWRif convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2011 13:38:35 -0400
Received: by iwn34 with SMTP id 34so4972757iwn.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=UfBi7KuGnpfVTMQchiZyvHJBtLytUISl9M5YKZRzd5Y=;
        b=hFdW8YGafA12XOSva0eYxPG5krp6mCpoFZ+syqLdYame67OV4bUp5nb0tRrWTUTwaU
         IpBFhPYX/Fa4Ritm7Yemrl+V1sUi+3crxqDQTGA1RbjVduZ3wjOyrN9oWjPV4km01CaW
         xs+V7ofEVEbGY8xpBuiEwMbO4mYGRSSRNo4nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FpWlh0szQlQXp96Z+riZJQu48lGTAzJBXWDwsdTl5pMj4DfkIUrvvWB3grb4eHOCgj
         obx9hAo7dTyKlOrJIaH59jpTFVCTeEIdanbGNxDv2m0mzTZqWT1C95MX3GlARcADADeW
         kv20sMe6yiUx3c5Aw9morArFtB51jIqMAMZ0k=
Received: by 10.231.197.27 with SMTP id ei27mr2287940ibb.198.1306172313113;
 Mon, 23 May 2011 10:38:33 -0700 (PDT)
Received: by 10.231.17.66 with HTTP; Mon, 23 May 2011 10:38:03 -0700 (PDT)
In-Reply-To: <34E33A18-B9C4-4CA9-B96C-79B0E2BDCD44@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174256>

Hi Grant,

> The "Branch-foo" that git-p4 is crashing on does have a branchspec in
> Perforce. =A0I cannot, however guarantee that branchspecs were
> correctly created and used for all integrates in the repository. =A0I=
t
> was created long before I started working here.

You can create the branch specs now. There is no requirement for them t=
o
have been created at the time of the integration.

I've sent a patch to this mailing list [1] that adds the possibility of
creating these branches in a gitconfig file. If you feel brave enough,
please give it a try. The patch is missing a test case, which I still
did not have time to review and send

> Is there a way to limit --detect-branches to only certain branches
> that I can ensure do have branchspecs?

If you have an incremental structure you could limit the cloning to a
subset of the directories. I am not aware of any other way. Maybe
someone else in the mailing list can shed some light...? :)

Vitor

[1] http://thread.gmane.org/gmane.comp.version-control.git/167998/focus=
=3D168000
