From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Conflict markers in mergetool $LOCAL ?
Date: Tue, 17 Aug 2010 11:00:14 -0700
Message-ID: <f595ee73-b1a3-4797-bf55-20c0f1b309e0@email.android.com>
References: <loom.20100817T054731-955@post.gmane.org> <20100817093008.GA26357@gmail.com> <loom.20100817T185804-167@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
To: Seth House <seth@eseth.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 20:00:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlQSN-0003Qy-47
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 20:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758051Ab0HQSAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 14:00:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37715 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0HQSAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 14:00:08 -0400
Received: by fxm13 with SMTP id 13so3652766fxm.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 11:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:x-user-agent:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :subject:from:date:to:message-id;
        bh=u8Ey+OzmUYR4Q0S2j/5T5pgv5LdsKTKCsHGh5LSbD/M=;
        b=Eb0olFrhSGKhT8YAlVYU5PpfpRpy8BCDcOFkvvqOe2M4TxcgShOB5DzC1fFEe9SIeh
         oCA5KV2WYa5fU1g3NmlIqzQLi5GD/vrFI/l42WABrQVB/mnHonvc+69hRL/xxxOK55rL
         hBPRswPy50WMMH64W133ehb/v7Nw33SZGCDmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:message-id;
        b=ihgnutEKmTreCT/KwFunubenYM+ET7mgvpChtIieW34I6haDxtdB9o1L/xvqhr+CqE
         NNCyWbPokp+sy8q428te21lyo1jumyE4XOBF8qPDLnQYry25EG4SN4sL82TBEr7RgWKz
         9fbkL0cAtu9hjG/pj6Brvd4Wt8kxlmorJvol4=
Received: by 10.223.104.134 with SMTP id p6mr6936558fao.10.1282068007208;
        Tue, 17 Aug 2010 11:00:07 -0700 (PDT)
Received: from 92.sub-70-196-214.myvzw.com (92.sub-70-196-214.myvzw.com [70.196.214.92])
        by mx.google.com with ESMTPS id k25sm3124844fac.41.2010.08.17.11.00.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 11:00:05 -0700 (PDT)
X-User-Agent: K-9 Mail for Android
In-Reply-To: <loom.20100817T185804-167@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153771>

That actually looks exactly like it should.  The order of the windows that vimdiff uses is (IIRC): ours, on-disk file, theirs.

"Seth House" <seth@eseth.com> wrote:

>David Aguilar <davvid <at> gmail.com> writes:
>> What happens if you remove this section?:
>
>Same result. The conflict markers are still there:
>
>http://i.imgur.com/d1vp1.png
>
>--
>To unsubscribe from this list: send the line "unsubscribe git" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
