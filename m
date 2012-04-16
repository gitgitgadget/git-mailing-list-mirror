From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 18:05:50 -0500
Message-ID: <20120416230550.GV12613@burratino>
References: <7vaa2by8nj.fsf@alter.siamese.dyndns.org>
 <20120416160729.GM5813@burratino>
 <CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
 <20120416200941.GD12613@burratino>
 <CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
 <20120416203320.GF12613@burratino>
 <7v7gxftn78.fsf@alter.siamese.dyndns.org>
 <CAMP44s1TkE=rd8AxbBnR4a8FwY+H9MHxYOhcks9fsnuK1iL_oA@mail.gmail.com>
 <20120416224411.GU12613@burratino>
 <CAMP44s0cdSaiCoMLk7oTHE4dies5-G0C7-RczK5OFEK=pYUW_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 01:06:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJuzl-0004Zd-3e
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 01:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819Ab2DPXGB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 19:06:01 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40421 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755652Ab2DPXF7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 19:05:59 -0400
Received: by iagz16 with SMTP id z16so8067845iag.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 16:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LEFcQm2HVsQrK6xPafn22iPwzfF5L5V3PBmdc9Q8yGg=;
        b=zC1Hml62rJDdWwMQhQgZOVcSh+lIRV8hgNrFViQ+vz2pD4UMH79fmJYyRvWfcVIBjk
         4ymoe+oHf7mAFzsDTGuSDEVwY9XqR7Yggsy3SflYDsS/LZjPh55U2dbUrJTFqpXhkkV7
         aXuomlJ0tphl6XnGcE5KVgfoGmk5bEboDF/stR/CVSIyQuF45tCJ2hgubCkRYMX+yQD5
         4fWvv0hCZP+tcXreAKQ9VRXHlig/3C9o+cn8biZEWicDxvPmcTH2udPbkZeS8XyAMtyU
         VWxl/Q6AMz8KElsYGkvzH16CtM7SncylxhmY+XBAhKcR1cq6UDZbfOFQBVNlbPToQ/f3
         Gsrw==
Received: by 10.50.189.232 with SMTP id gl8mr7486731igc.50.1334617558819;
        Mon, 16 Apr 2012 16:05:58 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id df1sm12663305igb.12.2012.04.16.16.05.57
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 16:05:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s0cdSaiCoMLk7oTHE4dies5-G0C7-RczK5OFEK=pYUW_A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195722>

=46elipe Contreras wrote:
> On Tue, Apr 17, 2012 at 1:44 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> What version of the bash_completion library do you use? =C2=A0Lazy-l=
oading
>> was introduced in version 1.90.
>
> 1.99

Is your git completion script installed at /etc/bash_completion.d/git,
/usr/share/bash-completion/completions/git, or somewhere else?
