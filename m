Received: from einhorn-mail-out.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3540B1707
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 16:11:45 -0800 (PST)
X-Envelope-From: oliver@first.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id 3B10Bgm71471029
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 1 Dec 2023 01:11:42 +0100
Date: Fri, 1 Dec 2023 01:11:41 +0100
From: Oliver Bandel <oliver@first.in-berlin.de>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: git@vger.kernel.org
Subject: Re: "git overlay" - command for overlaying branches
Message-ID: <6wyjngq772jjy5hbydegblbrviuvama4avyxof2olkjpey3ohi@drpwcb2eothu>
References: <n46dskd3hudzssaam56jesxr5elzdvs3asurqvbxkgsdcqitjs@qlufclnnjpsq>
 <20231124205945.GA9696@kitsune.suse.cz>
 <647focpqwyild7dbmw7dloc5q2irijk7z77ymmfut5zdjrqhzy@xsle27m6flun>
 <20231125105046.GB9696@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231125105046.GB9696@kitsune.suse.cz>

What I basically want to do is:

- Working on more than one branch at the same time.
- Having all checked-out branches together in one working dir.
- When adding/committing, all checked-out files will be added/committed
  to those branches, from where they were checked out.

This way I could edit multiple branches simultaneously independently without the need of merging.
Merging can be done later on, if needed.

Possible alternatives?

For the multiple checkouts I could do a workaround and use a local bare-repo
and check out each branch of interest into a seperate directory.
I could then edit the files from the different dirs.

But for the overlaying thing, to get the files into one dir
(with the automatic hiding of equally named files from branches that
were overlayed before) it would need something like a FUSE-based
tool, so that all the branches could be blended into one working dir.

A "git overlay" would make this easier.
No extra bare-repo needed, no additional tool for blending the dirs
needed.

Ciao,
  Oliver
