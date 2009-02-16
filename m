From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Mon, 16 Feb 2009 13:10:16 +0100
Message-ID: <2c6b72b30902160410g25e80514q318b65ea4614cdc1@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa>
	 <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
	 <op.uo9hiqqqa8ed4e@dellschleppa>
	 <2c6b72b30902151547q5bf183f2q1e846f261825671c@mail.gmail.com>
	 <slrngphgk1.hul.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 13:12:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ2Kw-0000mU-Ec
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 13:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbZBPMLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 07:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754234AbZBPMLE
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 07:11:04 -0500
Received: from mail-fx0-f25.google.com ([209.85.220.25]:61734 "EHLO
	mail-fx0-f25.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbZBPMLD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 07:11:03 -0500
Received: by fxm6 with SMTP id 6so1479808fxm.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 04:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dNVPv4X12+ep2Y8cKgd+hRmqjbc8btw2j4hLCacM1/I=;
        b=HABVFmMDVoAnvwoaAT0orciq4Ft1O756Jok7SgudVG0Ttnbucc/DVximphpUvZm2qD
         K3CKITZyN9s4D8rug8ZLaSLbO8+XYAFxHIu6vAW5i+lbqeExb4V8FPvMvoaGDk4jWjM3
         MplRfFNqpdOBAhQ7gcL1bS1IglagtqS4sd1hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x8e2DjDPizOa07WmbvTBsAAzPco1Ep7u5QXKccqbVuWBvFstwHaNwcyyu4U4p7RjUE
         6kdKXx0SjDnuv0aYPkOJeRcbiAc/B283Ib3ng8CsuqAuRgm0frrHJGjpTquUWwvDJzki
         qs8hUM2zyedzYojcNVWPH/929NBo2r1+0QjQE=
Received: by 10.181.24.14 with SMTP id b14mr260673bkj.104.1234786216568; Mon, 
	16 Feb 2009 04:10:16 -0800 (PST)
In-Reply-To: <slrngphgk1.hul.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110174>

On Mon, Feb 16, 2009 at 02:33, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On 2009-02-15, Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
>> patchset. One idea I would like to explore is to provide a compressed
>> version of the main view, where "intermediate" commits are hidden,
>> this way you could easily get a view of the relationship between
>> branches.
>
> like 'gitk --simplify-by-decoration --all'?

Great, didn't know about this option. If only tig could show the
revision graph properly ... ;)

-- 
Jonas Fonseca
