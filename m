From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [tig PATCH] treat empty '/' as "find next"
Date: Wed, 4 Feb 2009 10:02:56 +0100
Message-ID: <2c6b72b30902040102i13dbb667q631dee22a5735fc@mail.gmail.com>
References: <20090203054907.GA21695@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 04 10:04:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUdgH-000808-D7
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 10:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbZBDJDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 04:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbZBDJDA
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 04:03:00 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:30762 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbZBDJC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 04:02:58 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1976537fkf.5
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 01:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=KOqrNRO97WJl8qoJmfKxv8W6HPZo3kUJoJ592/cjGiw=;
        b=gzgbhlMSafbEMezaHLIArF66PsbudMecc/VmA3P0IOScRIIyrySDp1xMziaOCxBh7B
         IrTLEZFLN/2kEdM0Vuu3lZ4V1knJQPoe2V+6SUEUf0TAwWx3Pej14fdRoSbAS+cqacew
         eRejD9ovVrmTsF4F4cwqbKFrH3y7SNRkKdTgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=qXT7FShxyW1fpOtaNtPTmOPzmsh1tlVG7nzF07h0NhnUZLpftyLSljp9VfdSKLv2Gb
         aXLbH/INpa9ol74pA72ZA3mUjtIBZY3RALIiGGUT8FwH2EvFrg/HVWqfx+oYdK1R5e/x
         7SpTldgzihet56mYg5W4MviqopBvxV96Zb088=
Received: by 10.181.234.5 with SMTP id l5mr2426622bkr.124.1233738176099; Wed, 
	04 Feb 2009 01:02:56 -0800 (PST)
In-Reply-To: <20090203054907.GA21695@sigill.intra.peff.net>
X-Google-Sender-Auth: a6c8389cf7c07808
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108318>

On Tue, Feb 3, 2009 at 06:49, Jeff King <peff@peff.net> wrote:
> This patch causes tig, if there was a previous search, to
> find the next (or previous, if "?" was used) match in such a
> case.

Thanks, makes sense.

-- 
Jonas Fonseca
