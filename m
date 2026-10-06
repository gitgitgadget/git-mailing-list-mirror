Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA965375F80
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312358; cv=none; b=sf4whY5EQwoOi58OjjvVxBP8c1mFisNNENNtyeeUuLvPINlcNOxS2jZawtwPu9zbr2u++K+WXtPqu5NWrXy3oBGmRs0slnMDI3mSNBl0rh/vLpAj3g8HC98ap+gfF+UHasO6kdDWrG966UBQO9wr8mj309eDTmrwXqpKIoNURxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312358; c=relaxed/simple;
	bh=67J/EACpGMIaxMJbx9dd/GB1DehkS866qH+i1KeEgso=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9P9Qw90/GLHhdD1/62yv9MJQM8b1b2/W87whSFSypzXsY09xZErwwcyNHcXZ4KXTw2EYkiJDJQmoNTPaUry2UIDGCuavlFmCjzqE77TEPDfTJfrpHLcpltg6JRFKkCwXCWSiYKpG5CJJsPegLCkQSFDIN/2/Qa5sMhdElp0kjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=FhMD9ofr; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="FhMD9ofr"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 696IjgSx025072-696IjgT1025072
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 6 Oct 2026 21:45:42 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xEAAY-00DnpS-GR;
	Tue, 06 Oct 2026 21:45:42 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 21:45:42 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id fbdf54ca;
	Tue, 6 Oct 2026 18:45:42 +0000 (UTC)
Date: Tue, 6 Oct 2026 21:45:42 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
	<git@vger.kernel.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/2] [doc] Remove gittutorial-2
Message-ID: <20261006184542.V9Kze%taahol@utu.fi>
In-Reply-To: <xmqqfqyieokd.fsf@gitster.g>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
 <20261006055002.M9X9O%taahol@utu.fi> <xmqqfqyieokd.fsf@gitster.g>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-06.utu.fi (130.232.247.46) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhbWkgDGgEbHAcODg0aAAkdDxsK
 CQMDKA4JGxwFCQEERgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIXUhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWlpIDwEcDwEcDwkMDw0cKA8F
 CQEERgsHBUhYSFlfSA8BHBscDRooGAcKBxBGCwcFSFhIWVtIAh0EAQkoAh4GG0YLCUhYSFtaSAMaARscBw4ODRoACR0PGwoJAwMoDgkbHAUJAQRGCwcFSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=tGRQ1pwHpcPLjwcr7JTz0TsNEl0IL8WjOC3LG1L2jyU=;
 b=FhMD9ofrVkZRsW4oxNkoIm3b0k1zqUlm2Vu/v9ujNba0avEHYaO7Z88mHbRjbpSdWrdcHjFOMnED
	uSqCPtnPuNBN6YyXJWRqROmUXg1oIx6iQcS93hpB/fCXVnmU15Tb3KAItSYKLrGdV/DPyqsOF920
	Re5qxFfXSW1snNAq4M0wiAoBUcNOIDy9r5+tyvra8yZuM2REaMT2OJaj/0dwzdkF+I6iwxiTbyhY
	JYUlZqBODtWftCFFCd7LIAadXqeeJgp4+2UaLiG9gt/L+3pGlaUppp167TZ3JNOx8c/VSUTPZkmf
	k8oGR1sH5xvl+uf1PV6J6yljJbvDOhsrzM6J4Q==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> > And let's not worry about that exception you mentioned.  After this topic hits
> > 'next', I can rebase mine on top on of this, and deal with all necessary
> > integration work.
> 
> OK.  So ...
> 
>  - I'll tentatively eject both topics out of my tree,
> 
>  - Julia will send in a replacement that does not add gittutorial-2
>    to the command-list, which will be merged to 'next',
> 
>  - and then your topic will be queued again with an evil merge (by
>    me) to add gittutorial-2 back to the command-list file.
> 
> ... and both topics will be happy?

With an evil merge, or by stacking my topic on top of Julia's---which I think
is the cleaner solution because that way I can add gt-2 as a linter exemption
in the patch itself and explain it in the commit message.

And if "back to the command-list file" wasn't just a thinko, then no, I don't
see that gt-2 should be re-added to command-list.txt.
