From: =?ISO-8859-1?Q?Maxime_L=E9vesque?= <maxime.levesque@gmail.com>
Subject: Advice for "pseudo public" repository on a USB key for a single 
	contributer project
Date: Sat, 23 Jan 2010 13:27:04 -0500
Message-ID: <554f5f781001231027vd322045hf84e2a16208bcc9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 19:27:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYkhh-00033N-W6
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 19:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073Ab0AWS1J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jan 2010 13:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378Ab0AWS1J
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 13:27:09 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:63576 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab0AWS1F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jan 2010 13:27:05 -0500
Received: by pwi21 with SMTP id 21so1457699pwi.21
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 10:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=F83XQMxVGzn69PAL6vmyF9mlc5sCI2YNPUn30i0FnE8=;
        b=slaaFV8ITZFXWhQuB17YlcvNOpa7vub2YkjPxH/yBdR4s2VbjSGWA65SW7+T4H7w19
         8dT6xc78+OvJiiNReYP8cDWD7TLAVc6vIyb1TAMAa4KWSfN5GKhk+K1iMpCOwRMSSHcx
         MfY6mqygv5lQlACt/efXvDcDL037O/2Yk95UA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Jxk0oQqTZAaqFLdq7/tLv3Mk2vLf/a/xNlYhkNSj4e3ic2QLgYfRG1R+ALdUdHktHt
         1WXFaZTgBQ6Yo+4Fw1/eU95NtxSMaWUA3wMCtfTTk0tL43gWBvINO0ADkPFHqWqphSUR
         7eGbs2HV9NxLxrNlOljovkgMHHH0dsA/W8oIk=
Received: by 10.142.120.26 with SMTP id s26mr3122830wfc.157.1264271224813; 
	Sat, 23 Jan 2010 10:27:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137850>

 =A0 Hello Gitsers,

 =A0I'm a Git newbee, and I have started a project, with a few month's =
of code
 in
 a local git repository.

 I am the only develloper/contributor to this repo. I have a clone of m=
y
 repository
 on a USB key, for back up purposes. Once in a while I work on another
 machine
 where I have cloned a repo from the USB key.

 Since there are no servers involved, I have used pull command
 to move my 'HEAD' around :

 after working on machine1 I do :

 =A0 commit to machine1Repo
 =A0 machine1Repo=A0 --pull--> USBKeyRepo


 when I switch on machine2 I start by bringing it up to date from the k=
ey :


 =A0 machine2Repo=A0 <--pull-- USBKeyRepo

 =A0and when I'm finished=A0 :

 =A0commit to machine2Repo
 =A0machine1Repo=A0 --pull--> USBKeyRepo

 =A0So far I have done all of this using the master branch,
 and things don'g always go smoothly I sometimes have
 conflicts that don't seem logical, since I'm the only
 contrbutor, I should never need to do merges.

 =A0From what I have read my USBKey repo is like a public repo,
 so I have tried using a bare repo, because since I never work
 directly on the usb key, the souces on this repo are just
 adding unnecessary complexity. So far I had no success,
 because the pull command doesn't recognize my bare repo,
 it seems that bare repos must me accessed via a daemon process.

 =A0I suspect that I'm probably not using Git correctly (or optimally),
 which is why I am inquiring here.

 Should I be using a dedicated branch
 on each machine (as if I were two contributors) ?
 Is it wise to use pulls instead of pushes ?
 Should I be using a bare repo on my key ?


 =A0Any insight would be appreciated.

 Thank you all
