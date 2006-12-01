X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Stephan Feder <sf@b-i-t.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 17:04:19 +0100
Message-ID: <45705283.5080900@b-i-t.de>
References: <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se> <45701A24.5060500@b-i-t.de> <20061201121110.GP18810@admingilde.org> <45702C50.9050307@b-i-t.de> <20061201134311.GV18810@admingilde.org> <45703ACB.6050007@b-i-t.de> <20061201150746.GA18810@admingilde.org>
Reply-To: sf@b-i-t.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 1 Dec 2006 16:06:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
In-Reply-To: <20061201150746.GA18810@admingilde.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32939>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqAsX-0005oi-Fi for gcvg-git@gmane.org; Fri, 01 Dec
 2006 17:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967633AbWLAQE1 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006 11:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967665AbWLAQE1
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 11:04:27 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:33160 "HELO
 mail.medianet-world.de") by vger.kernel.org with SMTP id S967633AbWLAQE1
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006
 11:04:27 -0500
Received: (qmail 31407 invoked by uid 1011); 1 Dec 2006 16:04:26 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(0.0/5.0):.  Processed in
 0.224444 secs); 01 Dec 2006 16:04:26 -0000
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de)
 (213.157.15.184) by mail.medianet-world.de with SMTP; 1 Dec 2006 16:04:25
 -0000
Received: from [192.168.168.40] (groa.b-i-t.de [192.168.168.40]) by
 mail.b-i-t.de (Postfix) with ESMTP id 6E8A423347; Fri,  1 Dec 2006 17:04:20
 +0100 (CET)
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Martin Waitz wrote:
> hoi :)
>=20
> On Fri, Dec 01, 2006 at 03:23:07PM +0100, Stephan Feder wrote:
>> And what is already there is a lot of meta information (see above). =
You=20
>> do not need that.
>=20
> What information are you refering to?
> Perhaps you have looked into my old branch?
> The current implementation is in "module2".

I was looking into git-init-module.sh (branch module2). There you set u=
p=20
a separate git repository for the submodule and store references to it=20
into the supermodules's repository.

>=20
>> For example, in the index, if it is a commit (i.e. a subproject), st=
ore=20
>> the commit id (not the commit's tree id ).
>=20
> This is exactly what I have done.
>=20
>> Especially, extend update-index to be able to store a commit=20
>> instead of the tree.
>=20
> Done, except that update-index never stores trees ;-)

Yes, I forgot.

>> Or else, do not change what is recorded in the index. Then, at commi=
t=20
>> time, you not only commit the superproject but also all subprojects.
>=20
> But then submodules would be handled differently to files which I wan=
ted
> to avoid.

On the other hand, it feels more naturally to only commit at the end of=
=20
your work. So both alternatives have their merits.

>=20
>> To push and pull you have to extend the tools as well. That is the n=
ext=20
>> step.
>=20
> Also done.

I hope I have time to give your solution a try.

Regards

Stephan

--=20
b.i.t.
beratungsgesellschaft f=FCr informations-technologie mbh
Stephan Feder
elisabethenstr. 62   fon: +49(0)6151/827575
64283 darmstadt      fax: +49(0)6151/827576
mailto:sf@b-i-t.de   www: http://www.b-i-t.de
