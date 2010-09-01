From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Wed, 1 Sep 2010 00:11:47 -0300
Message-ID: <AANLkTim-onah671F=9sr4wfQFPBb-vWzjD9YKY5O7f2J@mail.gmail.com>
References: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
	<20100830023812.GA4010@burratino>
	<20100830024020.GB4010@burratino>
	<AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
	<AANLkTik7P2nC9zMp5+srrRNEAOKLcXnsJA5+_43S9A3=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 05:11:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqdju-0000f7-07
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 05:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071Ab0IADLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 23:11:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48290 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab0IADLt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 23:11:49 -0400
Received: by bwz11 with SMTP id 11so4992808bwz.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 20:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=wzeOlGcJn948teg/h8EjvSo6hAgvvTiBVmkLSOhRJlc=;
        b=xWfbIy2e8F9BZ8kzk4JnHfAcBXMNMICeVzRqNjV5Kavi+K3Mdk1wk1mEcodUxKpdZ2
         t+KkgByWZ92ujqw6CeU+eIpa/hNo020W06Gs3IZV9IQpJ0YnmBb/51NIbp9J7rBO4Yho
         NPP2QwqmWLn+3OtolBmCHlaiwgpIcmb5OCghA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=HX/EmCUebAcGWYlL7z8OquSjH7JkLHGSJY5g//WMnpokrx7fTzQN2hSuQaidlhwhGM
         VOtxPWNvSh/hqM+XN8QRB5Gx3Kl9K9N5CueUVt2toGqLOue0HRvKVXXt4M3lOnfbUyRd
         +XPhArsGR8ZkXsceFWZjEevJ76q+47g8DdX7g=
Received: by 10.204.72.209 with SMTP id n17mr5140500bkj.52.1283310707800; Tue,
 31 Aug 2010 20:11:47 -0700 (PDT)
Received: by 10.204.25.84 with HTTP; Tue, 31 Aug 2010 20:11:47 -0700 (PDT)
In-Reply-To: <AANLkTik7P2nC9zMp5+srrRNEAOKLcXnsJA5+_43S9A3=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155010>

On Wed, Sep 1, 2010 at 12:04 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Not my call, but should you also update .gitignore to ignore git-version?

Thanks for the catch, fixed in patchset v2.
