From: =?ISO-8859-1?Q?Rodrigo_Cort=E9s?= <rcortes.ing@gmail.com>
Subject: Re: Tracking database changes.
Date: Thu, 8 Sep 2011 09:16:09 -0300
Message-ID: <CAFSYZ5T1fhej26KfT1TtGQ6+U4=v1YxV1uTTD=poYNeQW15w5g@mail.gmail.com>
References: <30328581.178675.1315346163453.JavaMail.trustmail@mail1.terreactive.ch>
	<20110908121225.GC32087@victor.terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-1?Q?Rodrigo_Cort=E9s?= <rcortes.ing@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 14:16:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1dWj-0004pv-4w
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 14:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556Ab1IHMQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Sep 2011 08:16:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41926 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932400Ab1IHMQJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2011 08:16:09 -0400
Received: by yxp4 with SMTP id 4so391585yxp.19
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=j2WJfgTj3pKuhIUP8T6e5Kw76i8T3D+38jxXSJXRMwA=;
        b=bNjBNQDFSb9+SiVu9VS7I6t8e/bFLRe7nMziAatO79f9z4XYPHMAYJPJSPAFFTT5oL
         tbVoJSRerUMhiPViWIYjAxv64krYAf33ehUYyL5s2pzwvkBx5LHVy2lEUDNORukCfxBy
         qkv0fiU/0a6zBqUh1ghLRvc2gqGkYXd6jnHp8=
Received: by 10.231.73.209 with SMTP id r17mr521960ibj.0.1315484169127; Thu,
 08 Sep 2011 05:16:09 -0700 (PDT)
Received: by 10.231.61.82 with HTTP; Thu, 8 Sep 2011 05:16:09 -0700 (PDT)
In-Reply-To: <20110908121225.GC32087@victor.terreactive.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180966>

So... there is no "plugin" for git to do that work.

On Thu, Sep 8, 2011 at 9:12 AM, Victor Engmark
<victor.engmark@terreactive.ch> wrote:
> On Tue, Sep 06, 2011 at 06:55:56PM -0300, Rodrigo Cort=E9s wrote:
>> Is there a way to use git to track database changes?
>
> 1. Export the data and/or data model with a tool like mysqldump.
> 2. Remove output which would clutter up your diffs without adding any
> useful information. This could include things like date and time of t=
he
> export and user name of the exporter.
> 3. Commit and enjoy!
>
> Optionally create a cron job to export and commit automatically durin=
g
> off-peak hours.
>
> Cheers,
> Victor
>
> --
> terreActive AG
> Kasinostrasse 30
> CH-5001 Aarau
> Tel: +41 62 834 00 55
> Fax: +41 62 823 93 56
> www.terreactive.ch
>
> Wir sichern Ihren Erfolg - seit 15 Jahren
>



--=20
Rodrigo Cort=E9s Carvajal
Ingenier=EDa El=E9ctrica
Universidad Tecnol=F3gica de Chile
