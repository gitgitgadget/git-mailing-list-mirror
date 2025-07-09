Received: from mail.femto-st.fr (lifc.univ-fcomte.fr [194.57.88.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58621EF39F
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.57.88.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056656; cv=none; b=BepUaT574Ilhr0LO3uBrAHoc/Mt6c9u0m4Z3rB2pYQxp4K2Mkk7xFyxvcmWPcNHPHVHQ8QfsWZEulltYm3OYHeNNJsSPiHDoXkdir7COr4oSKGy0XTkST+ByrUt1m4AKD+8ct0Gdi6B28kNT7yp3b9jA6VVKeykIjyvbNS2H3G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056656; c=relaxed/simple;
	bh=2Ynq+Q5aqTjYbX4uU66IkfOjIwFc5+OU/9eNUEJi5hE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=id5xQKcGy3UnTvhyJ3X+jLwa7cr8n8CGNjeMFuuvt0r+rV3lYTIAGtMhir1tm7bBN0RZLZQ4ENtWyc0O2TSVVrPOznjCPcQEczxB8hnU8HJLXBrFvsGuibcNDyShp8CkHjB3E9MwDAbMCpa8gsePsO3kHr7UT6+uz+D/snWO88k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=femto-st.fr; spf=pass smtp.mailfrom=femto-st.fr; dkim=pass (2048-bit key) header.d=femto-st.fr header.i=@femto-st.fr header.b=ZardWZD4; arc=none smtp.client-ip=194.57.88.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=femto-st.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=femto-st.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=femto-st.fr header.i=@femto-st.fr header.b="ZardWZD4"
Received: from [172.16.120.214] ([194.167.45.244])
	(authenticated bits=0)
	by mail.femto-st.fr (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id 569ANOjS1091016
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 9 Jul 2025 12:23:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=femto-st.fr; s=mail;
	t=1752056604; bh=2Ynq+Q5aqTjYbX4uU66IkfOjIwFc5+OU/9eNUEJi5hE=;
	h=Date:To:From:Subject:From;
	b=ZardWZD4YEmKlPymWBOScDCspPNoQ6AaKiMhlj1l47Z1iIS+0JK6bEw1+/Q5ISGRT
	 BmBGDGSRtEST/JsURKf5kKXWgeiKBf0S5+FQ2JeVDTQBiY2TXeRS2WNiD0tdL8jwcA
	 +a2+8ZqqNvZehS+TWU45ds5WnvTnr435LoIBrxLQZBYlHIsN7hIjQuwMow291Yncwg
	 ZDbxGsmcuX0TzSBvJIJSz972a2y9VFrIY8oRB6o1fHMC3LJKa+lXtVApyJlEYn0fN+
	 IZS82BrmTdNn8cJPemJBoNcV4/iJ/NCiI/GowQBA0D4KAe/m6UcsJXueCb2tK924wB
	 keuXPGbThlkSg==
Message-ID: <d3ab5bcc-6f71-455c-933a-a63a9b39e8b9@femto-st.fr>
Date: Wed, 9 Jul 2025 12:23:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: fr-FR
From: Nicolas Ratier <nicolas.ratier@femto-st.fr>
Subject: Problem with gitk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 194.57.88.66

Hello,

I have this error with gitk :

$ gitk

and inside the window of gitk :

Erreur à l'exécution de git log :

wrong # args: should be

"safe_open_command_redirect cmd redir"


+ My git is clean (I tried git status, qgit etc ...)

+ I reinstall gitk without success

+ google don't have any information about the problem

+ and chatgpt doesn't give useful help ...

Thanks for help, I don't know what to do...

Nicolas




