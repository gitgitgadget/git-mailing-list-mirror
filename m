From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Stgit and refresh-temp
Date: Tue, 11 Nov 2008 17:59:02 +0000
Message-ID: <b0943d9e0811110959t4eb236bvd648fbca5e482911@mail.gmail.com>
References: <9e4733910811040537p4e88c09an94370154eca12778@mail.gmail.com>
	 <20081107054419.GA27146@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 19:00:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzxXG-0000Ag-8s
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 19:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbYKKR7G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Nov 2008 12:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbYKKR7G
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 12:59:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:18343 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbYKKR7F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Nov 2008 12:59:05 -0500
Received: by nf-out-0910.google.com with SMTP id d3so3288nfc.21
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 09:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BDCyPij/a0ktXQkFDFcFZPKGzHK3Ok2US5WuAIzVBWU=;
        b=uiomaDC8788TjLbABVqhCipLSQBm+fldZTyh5c+dUD6VQD6Sw+dy8ZiYc05y39d+PI
         FcA1HuQyOqK3TH50NhHIXz59oN5vjg5fEsFHtg1MNwBMrtZKnkwng/JhT0g7qPK9R8HR
         I45XrSCUD48aL7O00ToO/ze3tv5ibxGKsebYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nzda/f9xGvCq4aOJNwF6rmLD7CPV4Do6EDMgiMVlUJI3f5zbbmlqqjIIryYCWYZDUW
         Pxbdycw+zDMeXJIL6pR+6maxEbG2NhIiSMiJmHqC7NDR0AT+ztp4yxFwZSj4EeIKtPl4
         wMLZEUAkDOuyILO3/bDx4JNh1nfIh2UMEHRqc=
Received: by 10.187.243.17 with SMTP id v17mr2792671far.67.1226426342210;
        Tue, 11 Nov 2008 09:59:02 -0800 (PST)
Received: by 10.187.191.12 with HTTP; Tue, 11 Nov 2008 09:59:02 -0800 (PST)
In-Reply-To: <20081107054419.GA27146@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100662>

2008/11/7 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-11-04 08:37:24 -0500, Jon Smirl wrote:
>
>> I hit a case when refreshing a buried patch that needed a merge
>> conflict sorted out. I'm unable to recover out of the state.
>
> Hmm, so what you're saying is basically that you did something with
> "stg refresh -p" that caused a merge conflict, and that messed things
> up so that you needed to run "stg repair". Is that right?
>
> Have you been able to reproduce it? (I would like to add the failing
> case to the test suite.)

Could be related to this - if I run 'stg goto some-patch' and it fails
with a conflict, the HEAD points to the previous patch though the
stack has the conflicting patch as empty (which is normal) and the
conflicts in the index. Anything after that says HEAD and top not
equal and 'stg repair' is needed.

--=20
Catalin
