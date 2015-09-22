From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: document behavior of --ref and --notes DWIMery
Date: Tue, 22 Sep 2015 14:23:09 -0700
Message-ID: <xmqqpp1a1742.fsf@gitster.mtv.corp.google.com>
References: <1442953476-24537-1-git-send-email-jacob.e.keller@intel.com>
	<xmqq8u7y2nnq.fsf@gitster.mtv.corp.google.com>
	<1442955811.26280.50.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"mh\@glandium.org" <mh@glandium.org>,
	"mhagger\@alum.mit.edu" <mhagger@alum.mit.edu>,
	"johan\@herland.net" <johan@herland.net>,
	"jacob.keller\@gmail.com" <jacob.keller@gmail.com>
To: "Keller\, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 23:23:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeV20-0002rJ-AC
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 23:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934624AbbIVVXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 17:23:15 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35808 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934130AbbIVVXO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 17:23:14 -0400
Received: by pacfv12 with SMTP id fv12so20062369pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 14:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gGKVoT/Xy5QlA7vt6NGGBxa6pXu11ZntWx6IxeInu94=;
        b=tFe+kLa1oe31inIXVpkEkI5VoFx/ck1pMsk7HXN2BlCor8V8NKIXh2QUc2q1qWN1a9
         4QUf3Lf5wuiVSdoT8M+co7sbrTIvCeS5bvcw32gUcOhik6e4Da+H+A45sIQiPRyVQV8Y
         qQ8zdraYbtbjE5xQ1NHMG5V+ZNWNJGOuY+cp4pxhuwVTTaRTx9f7DLehNYMxPz9xGHfA
         mkgf/8a4qgGQU4GpqiZjyuTTH+kMJUWEp7BWB2igsrxonuzai+rILjggKvrFW19pv01k
         qzwQcX/oUPIPqgyUAHcI+1i5eTlG1wjD7bZFjP89vgNDU2xA9Fy9jMOXlK3YAVIIWJpI
         1qKg==
X-Received: by 10.66.191.131 with SMTP id gy3mr32511195pac.113.1442956993937;
        Tue, 22 Sep 2015 14:23:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id cn4sm3952391pbc.94.2015.09.22.14.23.12
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 14:23:13 -0700 (PDT)
In-Reply-To: <1442955811.26280.50.camel@intel.com> (Jacob E. Keller's message
	of "Tue, 22 Sep 2015 21:03:31 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278438>

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

> On Tue, 2015-09-22 at 13:40 -0700, Junio C Hamano wrote:
>> How about phrasing it totally differently?
>> 
>> 	The ref specifies the full refname when it begins with
>> 	`refs/notes/`; otherwise `ref/notes/` is prefixed to form a
>> 	full name of the ref.
>> 
>> I think that would remove the need to illustrate with concrete
>> examples like refs/heads/blah.
>> 
>
> Wait, what about the DWIM of notes/<name> goes to refs/notes/<name>..
> do we need to explain that here?

Yeah, throw that in, too.

	... when it begins with `refs/notes/`; when it begins with
	`notes/`, `refs/` and otherwise `refs/notes/` is prefixed to
	form a full name of the ref.

We could emphasize the end result by ending the sentence like so:

	... form a full name of the ref that is under `refs/notes/`.

if you wanted to.  I am neutral (I do not think it would hurt, but I
do not think it adds much clarity).

Thanks.
