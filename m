From: Alex Blewitt <alex@bandlem.com>
Subject: Re: [EGit PATCH] IgnoreAction to add to .gitignore files
Date: Thu, 23 Apr 2009 13:32:46 +0100
Message-ID: <0A94BEDB-37A1-44D2-BE54-D05F0C3124EE@bandlem.com>
References: <20090423115042.743E6D9CDC@apple.int.bandlem.com> <200904231427.29832.fge@one2team.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, robin.rosenberg@dewire.com,
	spearce@spearce.org
To: Francis Galiegue <fge@one2team.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 14:34:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwy8I-0001BA-Bl
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 14:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756936AbZDWMcw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 08:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757165AbZDWMcw
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 08:32:52 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:50923 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935AbZDWMcv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 08:32:51 -0400
Received: by ewy24 with SMTP id 24so475064ewy.37
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 05:32:49 -0700 (PDT)
Received: by 10.210.12.13 with SMTP id 13mr5361305ebl.90.1240489969402;
        Thu, 23 Apr 2009 05:32:49 -0700 (PDT)
Received: from apple.int.bandlem.com (server.bandlem.com [217.155.97.60])
        by mx.google.com with ESMTPS id 24sm288eyx.13.2009.04.23.05.32.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 05:32:48 -0700 (PDT)
In-Reply-To: <200904231427.29832.fge@one2team.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117337>

Actually, that's pretty much exactly the format that Eclipse users =20
will be expecting.

CVS: Add to .cvsignore
SVN: Add to svn:ignore

I suggest that we go with that style of format for the menu items, in =20
order to achieve consistency with the way that the other team =20
providers work.

Note also that the tooltip is usually much shorter than that ... it's =20
not a full help description, it explains what it does.

Alex

On 23 Apr 2009, at 13:27, Francis Galiegue wrote:

> Le jeudi 23 avril 2009, Alex Blewitt a =E9crit :
>> diff --git a/org.spearce.egit.ui/plugin.properties
> b/org.spearce.egit.ui/plugin.properties
>> index 523a959..be3b40c 100644
>> --- a/org.spearce.egit.ui/plugin.properties
>> +++ b/org.spearce.egit.ui/plugin.properties
>> @@ -52,10 +52,12 @@ FetchAction_tooltip=3DFetch from another reposit=
ory
>> PushAction_label=3D&Push To...
>> PushAction_tooltip=3DPush to another repository
>>
>> +IgnoreAction_label=3DAdd to .git&ignore...
>> +IgnoreAction_tooltip=3DIgnore the selected resources
>> +
>> GitActions_label=3DGit
>> GitMenu_label=3D&Git
>>
>
> The label and tooltip are too "git-specific", IMHO. I'd rather see:
>
> IgnoreAction_label=3D&Ignore file(s) for commits...
> IgnoreAction_tooltip=3DThe selected file(s) will not be included by =20
> default in
> your commits. However, you may force the include of these files in a =
=20
> commit
> by explicitly adding them via "Team->Add" [or whatever the label is].
> \n\nSelecting files to ignore by this mechanism will automatically =20
> add one or
> more files named .gitignore in your next commit.
>
> --=20
> Francis Galiegue
> ONE2TEAM
> Ing=E9nieur syst=E8me
> Mob : +33 (0) 683 877 875
> Tel : +33 (0) 178 945 552
> fge@one2team.com
> 40 avenue Raymond Poincar=E9
> 75116 Paris
