From: "Miles Bader" <miles@gnu.org>
Subject: Re: [PATCH] fast importer for SCCS files
Date: Mon, 21 Jan 2008 17:01:14 +0900
Message-ID: <fc339e4a0801210001t463360a8t5ff91a1729d87b4b@mail.gmail.com>
References: <c5df85930801200312o7cd5d307v1a39fb35179249a9@mail.gmail.com>
	 <7vsl0s57e8.fsf@gitster.siamese.dyndns.org>
	 <buo7ii3pvwb.fsf@dhapc248.dev.necel.com>
	 <7v7ii33d82.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miles Bader" <miles@gnu.org>, "James Youngman" <jay@gnu.org>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 09:01:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGrbG-0002SF-D7
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 09:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744AbYAUIBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 03:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757504AbYAUIBR
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 03:01:17 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:45205 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119AbYAUIBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 03:01:16 -0500
Received: by an-out-0708.google.com with SMTP id d31so418382and.103
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 00:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=7cohriJUcoI5zcmc83dhtOvZEl9TTwZCOexstSGTaYQ=;
        b=PKIXhuLJAOj2J/2O3igo+f9VJuPIRBrMzPUeISZoIBPOOTw6pN/3JmTtE6G6V+i7eJqPHkOTVRZHmmxQaDnbHhyJYXpuLI8DEEtuj5I75fszQhfS0UdNIqSdlulT/rlkdITdoYA6CGXp3i3e13LU8dzqCsvuXIKC6LW/FFG31p0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=tEbs/XIY1+p2b58tcVJLXJleIb3Fv/xEG1BlGE+byxl+Xwqx2ELNKIgVefankkyrKBApuJqAKEayk2ouZtTGTd+BtQR7vrt1JhwCQTKuaVlXIoXeFdBq1McNg/TtnA/OtitNprd7cuGCXIP73vCZzZLFVSjg1VFcg7Z7VfDmXd4=
Received: by 10.100.231.16 with SMTP id d16mr14110604anh.64.1200902474770;
        Mon, 21 Jan 2008 00:01:14 -0800 (PST)
Received: by 10.101.70.4 with HTTP; Mon, 21 Jan 2008 00:01:14 -0800 (PST)
In-Reply-To: <7v7ii33d82.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: c7d3b247d84a70cf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71238>

On 1/21/08, Junio C Hamano <gitster@pobox.com> wrote:
> >> You seem to be using a tab-width that is not 8, and it shows
> >> everywhere.
> >
> > In a python script, too...
>
> We already seem to have two .py file under contrib/ and I do not
> particularly mind scripts written in Python in contrib/ area.

Actually I was just thinking that "messed up whitespace" is a much
deadlier sin in Python than in other languages...

-Miles

-- 
Do not taunt Happy Fun Ball.
