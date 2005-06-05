From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: cg-init bug
Date: Sun, 5 Jun 2005 10:56:34 -0700
Message-ID: <20050605175634.GB6890@tumblerings.org>
References: <20050605153053.GA6890@tumblerings.org> <20050605172854.GF17462@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 19:55:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DezKk-0005LE-8v
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 19:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVFER6J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 5 Jun 2005 13:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVFER6J
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 13:58:09 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:55020 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261600AbVFER4m
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 13:56:42 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DezMQ-0007ca-NZ; Sun, 05 Jun 2005 10:56:34 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050605172854.GF17462@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 05, 2005 at 07:28:54PM +0200, Petr Baudis wrote:
> Dear diary, on Sun, Jun 05, 2005 at 05:30:53PM CEST, I got a letter
> where Zack Brown <zbrown@tumblerings.org> told me that...
> > Hi,
>=20
> Hello,
>=20
> > I've been tracking Cogito. This problem occurred with Cogito versio=
n
> > 1e2673d606dd39dc44b4eed2204ba349a448bc4d
> >=20
> > I have a directory tree with several layers of subdirectories and a=
bout 1700
> > files. I tried to convert it to a git repository with 'cg-init'.
> >=20
> > The first thing I noticed was that not all the files and subdirecto=
ries had been
> > added. Doing a cg-status listed many files with '?' in front of the=
m.
> >=20
> > I tried adding these files with "cg-add */*", "cg-add */*/*" etc, f=
ollowed by
> > "cg-commit", and this seemed at first glance to work. I was able to=
 reduce
> > the number of files reported by "cg-status". But eventually "cg-add=
" would
> > say there were no files left to add, while "cg-status" would still =
list many
> > files unadded. It seemed that "cg-add" would only selectively add f=
iles.
> >=20
> > At that point I blew away the .git directory and gave up on repo-iz=
ing that
> > project for now.
> >=20
> > I can reproduce this problem easily. Please let me know if you need=
 any more
> > information.
>=20
> what are the files it would refuse to add?

Depending on how I check, I get very different lists. I'll include both=
 in this email.

If I do the 'cg-init' on the full source.cogito directory, then do a 'c=
g-clone'
into a new source.cogtst directory, here is the result of a comparison:

$ diff -ur source.cogito/ source.cogtst/|grep -v "\.git"|cut -d '/' -f =
2-|sed -e "s/: /\//"
/GNUe
/Makefile
/Makefile.cousinraw
/Makefile.cousinsite
/Makefile.globalvars
/arch
/asleep.xml
/author.xml
/authors
/bin
/crash.xml
/debian
/debian-hurd
/devel.xml
/donations.xml
/editor.xml
/favicon.ico
/gimp
/git
/gpl.txt
/help.xml
/index.xml
/irc.xml
/kde
kernel-traffic/quotes
kernel-traffic/raw
kernel-traffic/stats
kernel-traffic/topics
kernel-traffic/trans/czech/Makefile
kernel-traffic/trans/czech/Makefile.encoding
kernel-traffic/trans/czech/index.xml
kernel-traffic/trans/czech/kt20000110_50.xml.bak
kernel-traffic/trans/czech/kt20000117_51.xml.bak
kernel-traffic/trans/czech/kt20000124_52.xml.bak
kernel-traffic/trans/czech/kt20000207_53.xml.bak
kernel-traffic/trans/czech/kt20000214_54.xml.bak
kernel-traffic/trans/czech/kt20000221_55.xml.bak
kernel-traffic/trans/czech/kt20000228_56.xml.bak
kernel-traffic/trans/czech/kt20000306_57.xml.bak
kernel-traffic/trans/czech/kt20000313_58.xml.bak
kernel-traffic/trans/czech/kt20000320_59.xml.bak
kernel-traffic/trans/czech/kt20000327_60.xml.bak
kernel-traffic/trans/czech/kt20000403_61.xml.bak
kernel-traffic/trans/czech/kt20000410_62.xml.bak
kernel-traffic/trans/czech/kt20000417_63.xml.bak
kernel-traffic/trans/czech/kt20000424_64.xml.bak
kernel-traffic/trans/czech/kt20000501_65.xml.bak
kernel-traffic/trans/czech/kt20000507_66.xml.bak
kernel-traffic/trans/czech/kt20000515_67.xml.bak
kernel-traffic/trans/czech/kt20000522_68.xml.bak
kernel-traffic/trans/czech/kt20000529_69.xml.bak
kernel-traffic/trans/czech/kt20000605_70.xml.bak
kernel-traffic/trans/czech/kt20000612_71.xml.bak
kernel-traffic/trans/czech/kt20000619_72.xml.bak
kernel-traffic/trans/czech/kt20000626_73.xml.bak
kernel-traffic/trans/czech/kt20000703_74.xml.bak
kernel-traffic/trans/czech/kt20000710_75.xml.bak
kernel-traffic/trans/czech/kt20000717_76.xml.bak
kernel-traffic/trans/czech/kt20000724_77.xml.bak
kernel-traffic/trans/czech/kt20000731_78.xml.bak
kernel-traffic/trans/czech/kt20000807_79.xml.bak
kernel-traffic/trans/czech/kt20000814_80.xml.bak
kernel-traffic/trans/czech/kt20000821_81.xml.bak
kernel-traffic/trans/czech/kt20000828_82.xml.bak
kernel-traffic/trans/czech/kt20000904_83.xml.bak
kernel-traffic/trans/czech/kt20000911_84.xml.bak
kernel-traffic/trans/czech/kt20000918_85.xml.bak
kernel-traffic/trans/czech/kt20000925_86.xml.bak
kernel-traffic/trans/czech/kt20001002_87.xml.bak
kernel-traffic/trans/czech/kt20001010_88.xml.bak
kernel-traffic/trans/czech/kt20001016_89.xml.bak
kernel-traffic/trans/czech/kt20001023_90.xml.bak
kernel-traffic/trans/czech/kt20001030_91.xml.bak
kernel-traffic/trans/czech/kt20001106_92.xml.bak
kernel-traffic/trans/czech/kt20001113_93.xml.bak
kernel-traffic/trans/czech/kt20001120_94.xml.bak
kernel-traffic/trans/czech/kt20001127_95.xml.bak
kernel-traffic/trans/czech/kt20001204_96.xml.bak
kernel-traffic/trans/czech/kt20001211_97.xml.bak
kernel-traffic/trans/czech/kt20001218_98.xml.bak
kernel-traffic/trans/czech/kt20001225_99.xml.bak
kernel-traffic/trans/czech/kt20010101_100.xml.bak
kernel-traffic/trans/czech/kt20010108_101.xml.bak
kernel-traffic/trans/czech/kt20010112_102.xml.bak
kernel-traffic/trans/czech/kt20010119_103.xml.bak
kernel-traffic/trans/czech/kt20010126_104.xml.bak
kernel-traffic/trans/czech/kt20010202_105.xml.bak
kernel-traffic/trans/czech/kt20010209_106.xml.bak
kernel-traffic/trans/czech/kt20010216_107.xml.bak
kernel-traffic/trans/czech/kt20010223_108.xml.bak
kernel-traffic/trans/czech/kt20010302_109.xml.bak
kernel-traffic/trans/czech/kt20010309_110.xml.bak
kernel-traffic/trans/czech/kt20010316_111.xml.bak
kernel-traffic/trans/czech/kt20010323_112.xml.bak
kernel-traffic/trans/czech/kt20010330_113.xml.bak
kernel-traffic/trans/czech/kt20010416_114.xml.bak
kernel-traffic/trans/czech/kt20010917_133.xml.bak
kernel-traffic/trans/czech/kt20020128_152.xml.bak
kernel-traffic/trans/czech/kt20020211_153.xml.bak
kernel-traffic/trans/czech/kt20020218_154.xml.bak
kernel-traffic/trans/czech/kt20020225_155.xml.bak
kernel-traffic/trans/czech/kt20020304_156.xml.bak
kernel-traffic/trans/czech/kt20020311_157.xml.bak
kernel-traffic/trans/czech/kt20020318_158.xml.bak
kernel-traffic/trans/czech/kt20020325_159.xml.bak
kernel-traffic/trans/czech/kt20020401_160.xml.bak
kernel-traffic/trans/czech/kt20020407_161.xml.bak
kernel-traffic/trans/czech/kt20020415_162.xml.bak
kernel-traffic/trans/czech/kt20020422_163.xml.bak
kernel-traffic/trans/czech/kt20020429_164.xml.bak
kernel-traffic/trans/czech/kt20020506_165.xml.bak
kernel-traffic/trans/czech/kt20020513_166.xml.bak
kernel-traffic/trans/czech/kt20020520_167.xml.bak
kernel-traffic/trans/czech/kt20020527_168.xml.bak
kernel-traffic/trans/czech/kt20020603_169.xml.bak
kernel-traffic/trans/czech/kt20020609_170.xml.bak
kernel-traffic/trans/czech/kt20020617_171.xml.bak
kernel-traffic/trans/czech/kt20020624_172.xml.bak
kernel-traffic/trans/czech/kt20020708_174.xml.bak
kernel-traffic/trans/czech/kt20020715_175.xml.bak
kernel-traffic/trans/czech/kt20020722_176.xml.bak
kernel-traffic/trans/czech/kt20020805_178.xml.bak
kernel-traffic/trans/czech/kt20020812_179.xml.bak
kernel-traffic/trans/czech/kt20020819_180.xml.bak
kernel-traffic/trans/czech/kt20020826_181.xml.bak
kernel-traffic/trans/czech/kt20020902_182.xml.bak
kernel-traffic/trans/czech/kt20020909_183.xml.bak
kernel-traffic/trans/czech/kt20020916_184.xml.bak
kernel-traffic/trans/czech/kt20020923_185.xml.bak
kernel-traffic/trans/czech/kt20020930_186.xml.bak
kernel-traffic/trans/czech/kt20021007_187.xml.bak
kernel-traffic/trans/czech/kt20021014_188.xml.bak
kernel-traffic/trans/czech/kt20021021_189.xml.bak
kernel-traffic/trans/czech/kt20021028_190.xml.bak
kernel-traffic/trans/czech/kt20021111_191.xml.bak
kernel-traffic/trans/czech/kt20021118_192.xml.bak
kernel-traffic/trans/czech/kt20021125_193.xml.bak
kernel-traffic/trans/czech/kt20021202_194.xml.bak
kernel-traffic/trans/czech/kt20021209_195.xml.bak
kernel-traffic/trans/czech/kt20021216_196.xml.bak
kernel-traffic/trans/czech/kt20021223_197.xml.bak
kernel-traffic/trans/czech/kt20021230_198.xml.bak
kernel-traffic/trans/czech/kt20030106_199.xml.bak
kernel-traffic/trans/czech/kt20030113_200.xml.bak
kernel-traffic/trans/czech/kt20030117_201.xml.bak
kernel-traffic/trans/czech/kt20030124_202.xml.bak
kernel-traffic/trans/czech/kt20030131_203.xml.bak
kernel-traffic/trans/czech/kt20030209_204.xml.bak
kernel-traffic/trans/czech/kt20030216_205.xml.bak
kernel-traffic/trans/czech/kt20030223_206.xml.bak
kernel-traffic/trans/czech/kt20030302_207.xml.bak
kernel-traffic/trans/czech/kt20030309_208.xml.bak
kernel-traffic/trans/czech/kt20030316_209.xml.bak
kernel-traffic/trans/czech/kt20030323_210.xml.bak
kernel-traffic/trans/czech/kt20030330_211.xml.bak
kernel-traffic/trans/czech/kt20030406_212.xml.bak
kernel-traffic/trans/czech/kt20030413_213.xml.bak
kernel-traffic/trans/czech/kt20030428_214.xml.bak
kernel-traffic/trans/czech/kt20030509_215.xml.bak
kernel-traffic/trans/czech/kt20030520_216.xml.bak
kernel-traffic/trans/czech/kt20030523_217.xml.bak
kernel-traffic/trans/czech/kt20030607_218.xml.bak
kernel-traffic/trans/czech/kt20030616_219.xml.bak
kernel-traffic/trans/czech/kt20030708_221.xml
kernel-traffic/trans/czech/kt20030710_222.xml
kernel-traffic/trans/czech/kt20030720_223.xml
kernel-traffic/trans/czech/kt20030730_224.xml
kernel-traffic/trans/czech/kt20030731_225.xml
kernel-traffic/trans/czech/kt20030805_226.xml.bak
kernel-traffic/trans/czech/kt20030811_227.xml
kernel-traffic/trans/czech/kt20030817_228.xml
kernel-traffic/trans/czech/kt20030908_229.xml
kernel-traffic/trans/czech/kt20030909_230.xml
kernel-traffic/trans/czech/kt20030910_231.xml
kernel-traffic/trans/czech/kt20030920_232.xml
kernel-traffic/trans/czech/kt20031004_233.xml
kernel-traffic/trans/czech/kt20031006_234.xml
kernel-traffic/trans/czech/kt20031024_235.xml
kernel-traffic/trans/czech/kt20031026_236.xml
kernel-traffic/trans/czech/kt20031026_237.xml
kernel-traffic/trans/czech/kt20031027_238.xml
kernel-traffic/trans/czech/kt20031101_239.xml
kernel-traffic/trans/czech/kt20031109_240.xml
kernel-traffic/trans/czech/kt20031116_241.xml
kernel-traffic/trans/czech/kt20031124_242.xml
kernel-traffic/trans/czech/kt20031201_243.xml
kernel-traffic/trans/czech/kt20031208_244.xml
kernel-traffic/trans/czech/kt20031214_245.xml
kernel-traffic/trans/czech/kt20031226_246.xml
kernel-traffic/trans/czech/kt20031231_247.xml
kernel-traffic/trans/czech/kt20040120_248.xml
kernel-traffic/trans/czech/kt20040127_249.xml
kernel-traffic/trans/czech/quotes
kernel-traffic/trans/czech/raw
kernel-traffic/trans/czech/topics
kernel-traffic/trans/french/quotes
kernel-traffic/trans/french/raw
kernel-traffic/trans/french/topics
kernel-traffic/trans/german/quotes
kernel-traffic/trans/german/raw
kernel-traffic/trans/german/topics
kernel-traffic/trans/polish/quotes
kernel-traffic/trans/polish/raw
kernel-traffic/trans/polish/topics
kernel-traffic/trans/spanish/quotes
kernel-traffic/trans/spanish/raw
kernel-traffic/trans/spanish/topics
reactos/quotes
reactos/raw
reactos/topics
reactos/trans
samba/quotes
samba/raw
samba/topics
slug-pearls/quotes
slug-pearls/raw
slug-pearls/topics
wine/quotes
wine/raw
wine/topics
wine/trans/polish/quotes
wine/trans/polish/raw

or about 222 files.

If instead of this I do a 'cg-status', I get the following output:

? GNUe/Makefile
? GNUe/back-issues.raw
? GNUe/gnue20011103_1.xml
? GNUe/gnue20011110_2.xml
? GNUe/gnue20011117_3.xml
? GNUe/gnue20011124_4.xml
? GNUe/gnue20011201_5.xml
? GNUe/gnue20011208_6.xml
? GNUe/gnue20011215_7.xml
? GNUe/gnue20011222_8.xml
? GNUe/gnue20011229_9.xml
? GNUe/gnue20020105_10.xml
? GNUe/gnue20020112_11.xml
? GNUe/gnue20020119_12.xml
? GNUe/gnue20020126_13.xml
? GNUe/gnue20020202_14.xml
? GNUe/gnue20020209_15.xml
? GNUe/gnue20020216_16.xml
? GNUe/gnue20020223_17.xml
? GNUe/gnue20020302_18.xml
? GNUe/gnue20020309_19.xml
? GNUe/gnue20020316_20.xml
? GNUe/gnue20020323_21.xml
? GNUe/gnue20020330_22.xml
? GNUe/gnue20020406_23.xml
? GNUe/gnue20020413_24.xml
? GNUe/gnue20020420_25.xml
? GNUe/gnue20020427_26.xml
? GNUe/gnue20020504_27.xml
? GNUe/gnue20020511_28.xml
? GNUe/gnue20020518_29.xml
? GNUe/gnue20020525_30.xml
? GNUe/gnue20020601_31.xml
? GNUe/gnue20020608_32.xml
? GNUe/gnue20020615_33.xml
? GNUe/gnue20020622_34.xml
? GNUe/gnue20020629_35.xml
? GNUe/gnue20020706_36.xml
? GNUe/gnue20020713_37.xml
? GNUe/gnue20020720_38.xml
? GNUe/gnue20020727_39.xml
? GNUe/gnue20020803_40.xml
? GNUe/gnue20020810_41.xml
? GNUe/gnue20020817_42.xml
? GNUe/gnue20020824_43.xml
? GNUe/gnue20020830_44.xml
? GNUe/gnue20020907_45.xml
? GNUe/gnue20020914_46.xml
? GNUe/gnue20020921_47.xml
? GNUe/gnue20020928_48.xml
? GNUe/gnue20021005_49.xml
? GNUe/gnue20021012_50.xml
? GNUe/gnue20021019_51.xml
? GNUe/gnue20021026_52.xml
? GNUe/gnue20021102_53.xml
? GNUe/gnue20021109_54.xml
? GNUe/gnue20021116_55.xml
? GNUe/gnue20021123_56.xml
? GNUe/gnue20021130_57.xml
? GNUe/gnue20021207_58.xml
? GNUe/gnue20021214_59.xml
? GNUe/gnue20021221_60.xml
? GNUe/gnue20021228_61.xml
? GNUe/gnue20030104_62.xml
? GNUe/gnue20030111_63.xml
? GNUe/gnue20030118_64.xml
? GNUe/gnue20030125_65.xml
? GNUe/gnue20030201_66.xml
? GNUe/gnue20030208_67.xml
? GNUe/gnue20030215_68.xml
? GNUe/gnue20030222_69.xml
? GNUe/gnue20030301_70.xml
? GNUe/gnue20030308_71.xml
? GNUe/gnue20030315_72.xml
? GNUe/gnue20030322_73.xml
? GNUe/gnue20030329_74.xml
? GNUe/gnue20030405_75.xml
? GNUe/gnue20030412_76.xml
? GNUe/gnue20030419_77.xml
? GNUe/gnue20030426_78.xml
? GNUe/gnue20030505_79.xml
? GNUe/gnue20030510_80.xml
? GNUe/gnue20030517_81.xml
? GNUe/gnue20030524_82.xml
? GNUe/gnue20030531_83.xml
? GNUe/gnue20030607_84.xml
? GNUe/gnue20030614_85.xml
? GNUe/gnue20030621_86.xml
? GNUe/gnue20030628_87.xml
? GNUe/gnue20030705_88.xml
? GNUe/gnue20030712_89.xml
? GNUe/gnue20030719_90.xml
? GNUe/gnue20030726_91.xml
? GNUe/gnue20030802_92.xml
? GNUe/gnue20030809_93.xml
? GNUe/gnue20030816_94.xml
? GNUe/gnue20030823_95.xml
? GNUe/gnue20031027_97.xml
? GNUe/gnue20031103_98.xml
? GNUe/gnue20031110_99.xml
? GNUe/gnue20031222_101.xml
? GNUe/gnue20031229_102.xml
? GNUe/gnue20040105_103.xml
? GNUe/gnue20040119_105.xml
? GNUe/gnue20040202_106.xml
? GNUe/index.xml
? GNUe/latest.xml
? Makefile
? Makefile.cousinraw
? Makefile.cousinsite
? Makefile.globalvars
? arch/Makefile
? arch/current.xml
? arch/index.xml
? arch/xml.template
? asleep.xml
? author.xml
? authors/Aaron_J._Seigo.html
? authors/Adam_Buchbinder.html
? authors/Alex_Harford.html
? authors/Arturas_Kriukovas.html
? authors/Benedikt_K=F6hler.html
? authors/Brian_Vincent.html
? authors/Charles_de_Miramon.html
? authors/Chris_Howells.html
? authors/Cris_Flagg.html
? authors/David_Mart=EDnez.html
? authors/Eric_Pouech.html
? authors/Eusebio_C_Rufian-Zilbermann.html
? authors/Fabrice_Mous.html
? authors/Henrique_Pinto.html
? authors/Jeff_Waugh.html
? authors/Jens_M=FCller.html
? authors/John_Guthrie.html
? authors/John_Quirk.html
? authors/Juergen_Appel.html
? authors/KDE_Promo_Team.html
? authors/KDE_Traffic_Team.html
? authors/Leif_Jensen.html
? authors/Mark_Zealey.html
? authors/Martin_Michlmayr.html
? authors/Paul_Emsley.html
? authors/Peter_Eckersley.html
? authors/Peter_Rockai_(mornfall).html
? authors/Peter_Samuelson.html
? authors/Peter_Sullivan.html
? authors/Prashanth_Mundkur.html
? authors/Rob_Kaper.html
? authors/Ronan_O'Sullivan.html
? authors/Russell_Miller.html
? authors/Sam_Phillips.html
? authors/Seth_Cohn.html
? authors/Simon_Law.html
? authors/Steve_Robbins.html
? authors/Timothy_R._Butler.html
? authors/Zack_Brown.html
? authors/Zack_Rusin.html
? bin/news2googleurl-4
? bin/readme
? bin/splitarchives
? bin/splitauthors
? bin/splitquotes
? bin/splittopics
? crash.xml
? debian-hurd/Makefile
? debian-hurd/back-issues.raw
? debian-hurd/dh19990603_1.xml
? debian-hurd/dh19990610_2.xml
? debian-hurd/dh19990617_3.xml
? debian-hurd/dh19990628_4.xml
? debian-hurd/dh19990706_5.xml
? debian-hurd/dh19990713_6.xml
? debian-hurd/dh19990720_7.xml
? debian-hurd/dh19990727_8.xml
? debian-hurd/dh19990803_9.xml
? debian-hurd/dh19990810_10.xml
? debian-hurd/dh19990817_11.xml
? debian-hurd/dh19990824_12.xml
? debian-hurd/dh19990831_13.xml
? debian-hurd/dh19990908_14.xml
? debian-hurd/dh19990914_15.xml
? debian-hurd/dh19990922_16.xml
? debian-hurd/dh19990929_17.xml
? debian-hurd/dh19991006_18.xml
? debian-hurd/dh19991013_19.xml
? debian-hurd/dh19991020_20.xml
? debian-hurd/dh19991027_21.xml
? debian-hurd/dh19991103_22.xml
? debian-hurd/dh19991110_23.xml
? debian-hurd/dh19991117_24.xml
? debian-hurd/dh19991201_25.xml
? debian-hurd/dh19991208_26.xml
? debian-hurd/dh19991215_27.xml
? debian-hurd/dh19991222_28.xml
? debian-hurd/dh19991229_29.xml
? debian-hurd/dh20000105_30.xml
? debian-hurd/dh20000112_31.xml
? debian-hurd/dh20000119_32.xml
? debian-hurd/dh20000126_33.xml
? debian-hurd/dh20000209_34.xml
? debian-hurd/dh20000216_35.xml
? debian-hurd/dh20000223_36.xml
? debian-hurd/dh20000301_37.xml
? debian-hurd/dh20000308_38.xml
? debian-hurd/dh20000315_39.xml
? debian-hurd/dh20000322_40.xml
? debian-hurd/dh20000329_41.xml
? debian-hurd/dh20000405_42.xml
? debian-hurd/dh20000412_43.xml
? debian-hurd/dh20000419_44.xml
? debian-hurd/dh20000426_45.xml
? debian-hurd/dh20000503_46.xml
? debian-hurd/dh20000510_47.xml
? debian-hurd/dh20000517_48.xml
? debian-hurd/dh20000524_49.xml
? debian-hurd/dh20000531_50.xml
? debian-hurd/dh20000607_51.xml
? debian-hurd/dh20000614_52.xml
? debian-hurd/dh20000628_53.xml
? debian-hurd/dh20000712_54.xml
? debian-hurd/dh20000726_55.xml
? debian-hurd/dh20000810_56.xml
? debian-hurd/dh20000816_57.xml
? debian-hurd/dh20000830_58.xml
? debian-hurd/dh20000913_59.xml
? debian-hurd/dh20000927_60.xml
? debian-hurd/dh20001004_61.xml
? debian-hurd/dh20001011_62.xml
? debian-hurd/dh20001018_63.xml
? debian-hurd/dh20001025_64.xml
? debian-hurd/dh20001101_65.xml
? debian-hurd/dh20001108_66.xml
? debian-hurd/dh20001115_67.xml
? debian-hurd/dh20001122_68.xml
? debian-hurd/dh20001129_69.xml
? debian-hurd/dh20001206_70.xml
? debian-hurd/dh20001213_71.xml
? debian-hurd/dh20001220_72.xml
? debian-hurd/dh20001227_73.xml
? debian-hurd/dh20010105_74.xml
? debian-hurd/dh20010110_75.xml
? debian-hurd/dh20010117_76.xml
? debian-hurd/dh20010124_77.xml
? debian-hurd/dh20010131_78.xml
? debian-hurd/dh20010210_79.xml
? debian-hurd/dh20010215_80.xml
? debian-hurd/dh20010222_81.xml
? debian-hurd/dh20010301_82.xml
? debian-hurd/dh20010309_83.xml
? debian-hurd/dh20010314_84.xml
? debian-hurd/dh20010320_85.xml
? debian-hurd/dh20010328_86.xml
? debian-hurd/dh20010420_87.xml
? debian-hurd/dh20010425_88.xml
? debian-hurd/dh20010502_89.xml
? debian-hurd/dh20010508_90.xml
? debian-hurd/dh20010515_91.xml
? debian-hurd/dh20010530_92.xml
? debian-hurd/dh20010611_93.xml
? debian-hurd/dh20010614_94.xml
? debian-hurd/dh20010621_95.xml
? debian-hurd/dh20010627_96.xml
? debian-hurd/dh20010703_97.xml
? debian-hurd/dh20010710_98.xml
? debian-hurd/dh20010717_99.xml
? debian-hurd/dh20010724_100.xml
? debian-hurd/dh20010730_101.xml
? debian-hurd/dh20010807_102.xml
? debian-hurd/dh20010814_103.xml
? debian-hurd/dh20010821_104.xml
? debian-hurd/dh20010828_105.xml
? debian-hurd/dh20010903_106.xml
? debian-hurd/dh20010911_107.xml
? debian-hurd/dh20010918_108.xml
? debian-hurd/dh20010925_109.xml
? debian-hurd/dh20011002_110.xml
? debian-hurd/dh20011009_111.xml
? debian-hurd/dh20011023_112.xml
? debian-hurd/dh20011030_113.xml
? debian-hurd/dh20011106_114.xml
? debian-hurd/dh20020319_115.xml
? debian-hurd/dh20020326_116.xml
? debian-hurd/dh20020409_117.xml
? debian-hurd/dh20020416_118.xml
? debian-hurd/dh20020618_119.xml
? debian-hurd/dh20020730_120.xml
? debian-hurd/hurdtalk1
? debian-hurd/hurdtalk1.1
? debian-hurd/hurdtalk1.2
? debian-hurd/hurdtalk1.3
? debian-hurd/hurdtalk1.4
? debian-hurd/index.xml
? debian-hurd/latest.xml
? debian-hurd/topics.pl
? debian-hurd/xml.template
? debian/Makefile
? debian/back-issues.raw
? debian/dd20000907_1.xml
? debian/dd20000914_2.xml
? debian/dd20000921_3.xml
? debian/dd20000928_4.xml
? debian/dd20001005_5.xml
? debian/dd20001012_6.xml
? debian/dd20001019_7.xml
? debian/dd20001026_8.xml
? debian/dd20001102_9.xml
? debian/dd20001109_10.xml
? debian/dd20001116_11.xml
? debian/dd20001123_12.xml
? debian/dd20001130_13.xml
? debian/dd20001214_14.xml
? debian/dd20001222_15.xml
? debian/dd20001229_16.xml
? debian/dd20010105_17.xml
? debian/dd20010112_18.xml
? debian/dd20010118_19.xml
? debian/dd20010125_20.xml
? debian/dd20010201_21.xml
? debian/dd20010210_22.xml
? debian/dd20010216_23.xml
? debian/dd20010222_24.xml
? debian/dd20010302_25.xml
? debian/dd20010312_26.xml
? debian/dd20010316_27.xml
? debian/dd20010328_28.xml
? debian/dd20020102_29.xml
? debian/index.xml
? debian/latest.txt
? debian/latest.xml
? debian/trans/german/Makefile
? debian/trans/german/Makefile.encoding
? debian/trans/german/dd20000907_1.xml
? debian/trans/german/dd20000914_2.xml
? debian/trans/german/index.xml.bak
? debian/trans/german/latest.txt
? debian/trans/german/latest.xml
? devel.xml
? donations.xml
? editor.xml
? favicon.ico
? gimp/Makefile
? gimp/back-issues.raw
? gimp/gd19990613_1.xml
? gimp/gd19990620_2.xml
? gimp/gd19990627_3.xml
? gimp/gd19990704_4.xml
? gimp/gd19990809_5.xml
? gimp/gd19990820_6.xml
? gimp/gd20000101_7.xml
? gimp/gd20000107_8.xml
? gimp/gd20000114_9.xml
? gimp/gd20000121_10.xml
? gimp/gd20000128_11.xml
? gimp/gd20000204_12.xml
? gimp/gd20000211_13.xml
? gimp/gd20000218_14.xml
? gimp/gd20000224_15.xml
? gimp/gd20000302_16.xml
? gimp/gd20000310_17.xml
? gimp/gd20000324_18.xml
? gimp/gd20000331_19.xml
? gimp/gd20000506_20.xml
? gimp/gd20000528_21.xml
? gimp/gd20000605_22.xml
? gimp/gd20000619_23.xml
? gimp/gd20000710_24.xml
? gimp/gd20001231_25.xml
? gimp/gd20010108_26.xml
? gimp/gd20010115_27.xml
? gimp/gd20010122_28.xml
? gimp/gd20010129_29.xml
? gimp/gd20010205_30.xml
? gimp/gd20010212_31.xml
? gimp/gd20010220_32.xml
? gimp/gd20010226_33.xml
? gimp/gd20010305_34.xml
? gimp/gd20010312_35.xml
? gimp/gd20010319_36.xml
? gimp/gd20010402_37.xml
? gimp/gd20010406_38.xml
? gimp/gd20010416_39.xml
? gimp/gd20010502_40.xml
? gimp/gd20010507_41.xml
? gimp/gd20010507_42.xml
? gimp/gd20010522_43.xml
? gimp/gd20010615_44.xml
? gimp/index.xml
? gimp/kde
? gimp/latest.xml
? git/Makefile
? git/back-issues.raw
? git/current.xml
? git/gt20050502_1.xml
? git/index.xml
? git/latest.xml
? git/topics.pl
? git/topics.raw
? git/xml.template
? gpl.txt
? help.xml
? index.xml
? irc.xml
? kde/Makefile
? kde/back-issues.raw
? kde/index.xml
? kde/kde20010310_1.xml
? kde/kde20010316_2.xml
? kde/kde20010324_3.xml
? kde/kde20010331_4.xml
? kde/kde20010406_5.xml
? kde/kde20010413_6.xml
? kde/kde20010420_7.xml
? kde/kde20010427_8.xml
? kde/kde20010511_9.xml
? kde/kde20010517_10.xml
? kde/kde20010525_11.xml
? kde/kde20010602_12.xml
? kde/kde20010608_13.xml
? kde/kde20010615_14.xml
? kde/kde20010622_15.xml
? kde/kde20010629_16.xml
? kde/kde20010713_17.xml
? kde/kde20010720_18.xml
? kde/kde20010803_19.xml
? kde/kde20010810_20.xml
? kde/kde20010824_21.xml
? kde/kde20011018_22.xml
? kde/kde20011026_23.xml
? kde/kde20011102_24.xml
? kde/kde20011109_25.xml
? kde/kde20011123_26.xml
? kde/kde20011130_27.xml
? kde/kde20011207_28.xml
? kde/kde20020104_29.xml
? kde/kde20020111_30.xml
? kde/kde20020118_31.xml
? kde/kde20020215_32.xml
? kde/kde20020222_33.xml
? kde/kde20020301_34.xml
? kde/kde20020308_35.xml
? kde/kde20020315_36.xml
? kde/kde20020522_37.xml
? kde/kde20020605_38.xml
? kde/kde20020619_39.xml
? kde/kde20020710_40.xml
? kde/kde20020724_41.xml
? kde/kde20020731_42.xml
? kde/kde20020821_43.xml
? kde/kde20021009_44.xml
? kde/kde20021028_45.xml
? kde/kde20021126_46.xml
? kde/kde20030419_47.xml
? kde/kde20030426_48.xml
? kde/kde20030504_49.xml
? kde/kde20030511_50.xml
? kde/kde20030517_51.xml
? kde/kde20030525_52.xml
? kde/kde20030602_53.xml
? kde/kde20030608_54.xml
? kde/kde20030618_55.xml
? kde/kde20030622_56.xml
? kde/kde20030702_57.xml
? kde/kde20030716_58.xml
? kde/kde20030722_59.xml
? kde/kde20030726_60.xml
? kde/kde20030811_61.xml
? kde/kde20030823_62.xml
? kde/kde20030901_63.xml
? kde/kde20030907_64.xml
? kde/kde20030929_65.xml
? kde/kde20031004_66.xml
? kde/kde20031109_67.xml
? kde/kde20031116_68.xml
? kde/kde20031130_69.xml
? kde/kde20031207_70.xml
? kde/kde20031214_71.xml
? kde/kde20031222_72.xml
? kde/kde20031231_73.xml
? kde/kde20040122_74.xml
? kde/kde20040227_75.xml
? kde/kde20040416_76.xml
? kde/latest.xml
? kde/sample.xml
? kde/trans/french/Makefile
? kde/trans/french/Makefile.encoding
? kde/trans/french/index.xml.bak
? kde/trans/french/kde20011018_22.xml
? kde/trans/french/kde20011026_23.xml
? kde/trans/french/kde20011102_24.xml
? kde/trans/french/kde20011109_25.xml
? kde/trans/french/kde20011123_26.xml
? kde/trans/french/kde20011130_27.xml
? kde/trans/french/kde20011207_28.xml
? kde/trans/french/kde20020104_29.xml
? kde/trans/french/kde20020111_30.xml
? kde/trans/french/kde20020118_31.xml
? kde/trans/french/kde20020215_32.xml
? kde/trans/french/kde20020308_35.xml
? kde/trans/french/kde20020522_37.xml
? kde/trans/french/kde20020619_39.xml
? kde/trans/french/kde20020710_40.xml
? kde/trans/french/kde20020724_41.xml
? kde/trans/french/kde20020731_42.xml
? kde/trans/french/kde20020821_43.xml
? kde/trans/french/kde20021009_44.xml
? kde/trans/french/kde20021028_45.xml
? kde/trans/french/kde20021126_46.xml
? kde/trans/french/latest.txt
? kde/trans/french/latest.xml
? kde/trans/german/Makefile
? kde/trans/german/Makefile.encoding
? kde/trans/german/kde20020522_37.xml
? kde/trans/german/kde20020522_37.xml.old
? kde/trans/german/kde20020605_38.xml
? kde/trans/german/latest.txt
? kde/trans/german/latest.xml
? kde/trans/spanish/Makefile
? kde/trans/spanish/Makefile.encoding
? kde/trans/spanish/index.xml.bak
? kde/trans/spanish/kde20020118_31.xml
? kde/trans/spanish/kde20020215_32.xml
? kde/trans/spanish/kde20020222_33.xml
? kde/trans/spanish/kde20020605_38.xml
? kde/trans/spanish/kde20020619_39.xml
? kde/trans/spanish/kde20020710_40.xml
? kde/trans/spanish/latest.txt
? kde/trans/spanish/latest.xml
? kernel-traffic/stats/Makefile
? kernel-traffic/stats/kt20050212_296_stats.xml
? kernel-traffic/stats/kt20050219_297_stats.xml
? kernel-traffic/stats/kt20050306_298_stats.xml
? kernel-traffic/stats/kt20050306_299_stats.xml
? kernel-traffic/stats/kt20050329_300_stats.xml
? kernel-traffic/stats/kt20050402_301_stats.xml
? kernel-traffic/stats/kt20050402_302_stats.xml
? kernel-traffic/stats/kt20050403_303_stats.xml
? kernel-traffic/stats/kt20050403_304_stats.xml
? kernel-traffic/stats/kt20050404_305_stats.xml
? kernel-traffic/stats/kt20050411_306_stats.xml
? kernel-traffic/stats/kt20050426_307_stats.xml
? kernel-traffic/stats/kt20050428_308_stats.xml
? kernel-traffic/stats/kt20050604_311_stats.xml
? kernel-traffic/trans/czech/Makefile
? kernel-traffic/trans/czech/Makefile.encoding
? kernel-traffic/trans/czech/index.xml
? kernel-traffic/trans/czech/kt20000110_50.xml.bak
? kernel-traffic/trans/czech/kt20000117_51.xml.bak
? kernel-traffic/trans/czech/kt20000124_52.xml.bak
? kernel-traffic/trans/czech/kt20000207_53.xml.bak
? kernel-traffic/trans/czech/kt20000214_54.xml.bak
? kernel-traffic/trans/czech/kt20000221_55.xml.bak
? kernel-traffic/trans/czech/kt20000228_56.xml.bak
? kernel-traffic/trans/czech/kt20000306_57.xml.bak
? kernel-traffic/trans/czech/kt20000313_58.xml.bak
? kernel-traffic/trans/czech/kt20000320_59.xml.bak
? kernel-traffic/trans/czech/kt20000327_60.xml.bak
? kernel-traffic/trans/czech/kt20000403_61.xml.bak
? kernel-traffic/trans/czech/kt20000410_62.xml.bak
? kernel-traffic/trans/czech/kt20000417_63.xml.bak
? kernel-traffic/trans/czech/kt20000424_64.xml.bak
? kernel-traffic/trans/czech/kt20000501_65.xml.bak
? kernel-traffic/trans/czech/kt20000507_66.xml.bak
? kernel-traffic/trans/czech/kt20000515_67.xml.bak
? kernel-traffic/trans/czech/kt20000522_68.xml.bak
? kernel-traffic/trans/czech/kt20000529_69.xml.bak
? kernel-traffic/trans/czech/kt20000605_70.xml.bak
? kernel-traffic/trans/czech/kt20000612_71.xml.bak
? kernel-traffic/trans/czech/kt20000619_72.xml.bak
? kernel-traffic/trans/czech/kt20000626_73.xml.bak
? kernel-traffic/trans/czech/kt20000703_74.xml.bak
? kernel-traffic/trans/czech/kt20000710_75.xml.bak
? kernel-traffic/trans/czech/kt20000717_76.xml.bak
? kernel-traffic/trans/czech/kt20000724_77.xml.bak
? kernel-traffic/trans/czech/kt20000731_78.xml.bak
? kernel-traffic/trans/czech/kt20000807_79.xml.bak
? kernel-traffic/trans/czech/kt20000814_80.xml.bak
? kernel-traffic/trans/czech/kt20000821_81.xml.bak
? kernel-traffic/trans/czech/kt20000828_82.xml.bak
? kernel-traffic/trans/czech/kt20000904_83.xml.bak
? kernel-traffic/trans/czech/kt20000911_84.xml.bak
? kernel-traffic/trans/czech/kt20000918_85.xml.bak
? kernel-traffic/trans/czech/kt20000925_86.xml.bak
? kernel-traffic/trans/czech/kt20001002_87.xml.bak
? kernel-traffic/trans/czech/kt20001010_88.xml.bak
? kernel-traffic/trans/czech/kt20001016_89.xml.bak
? kernel-traffic/trans/czech/kt20001023_90.xml.bak
? kernel-traffic/trans/czech/kt20001030_91.xml.bak
? kernel-traffic/trans/czech/kt20001106_92.xml.bak
? kernel-traffic/trans/czech/kt20001113_93.xml.bak
? kernel-traffic/trans/czech/kt20001120_94.xml.bak
? kernel-traffic/trans/czech/kt20001127_95.xml.bak
? kernel-traffic/trans/czech/kt20001204_96.xml.bak
? kernel-traffic/trans/czech/kt20001211_97.xml.bak
? kernel-traffic/trans/czech/kt20001218_98.xml.bak
? kernel-traffic/trans/czech/kt20001225_99.xml.bak
? kernel-traffic/trans/czech/kt20010101_100.xml.bak
? kernel-traffic/trans/czech/kt20010108_101.xml.bak
? kernel-traffic/trans/czech/kt20010112_102.xml.bak
? kernel-traffic/trans/czech/kt20010119_103.xml.bak
? kernel-traffic/trans/czech/kt20010126_104.xml.bak
? kernel-traffic/trans/czech/kt20010202_105.xml.bak
? kernel-traffic/trans/czech/kt20010209_106.xml.bak
? kernel-traffic/trans/czech/kt20010216_107.xml.bak
? kernel-traffic/trans/czech/kt20010223_108.xml.bak
? kernel-traffic/trans/czech/kt20010302_109.xml.bak
? kernel-traffic/trans/czech/kt20010309_110.xml.bak
? kernel-traffic/trans/czech/kt20010316_111.xml.bak
? kernel-traffic/trans/czech/kt20010323_112.xml.bak
? kernel-traffic/trans/czech/kt20010330_113.xml.bak
? kernel-traffic/trans/czech/kt20010416_114.xml.bak
? kernel-traffic/trans/czech/kt20010917_133.xml.bak
? kernel-traffic/trans/czech/kt20020128_152.xml.bak
? kernel-traffic/trans/czech/kt20020211_153.xml.bak
? kernel-traffic/trans/czech/kt20020218_154.xml.bak
? kernel-traffic/trans/czech/kt20020225_155.xml.bak
? kernel-traffic/trans/czech/kt20020304_156.xml.bak
? kernel-traffic/trans/czech/kt20020311_157.xml.bak
? kernel-traffic/trans/czech/kt20020318_158.xml.bak
? kernel-traffic/trans/czech/kt20020325_159.xml.bak
? kernel-traffic/trans/czech/kt20020401_160.xml.bak
? kernel-traffic/trans/czech/kt20020407_161.xml.bak
? kernel-traffic/trans/czech/kt20020415_162.xml.bak
? kernel-traffic/trans/czech/kt20020422_163.xml.bak
? kernel-traffic/trans/czech/kt20020429_164.xml.bak
? kernel-traffic/trans/czech/kt20020506_165.xml.bak
? kernel-traffic/trans/czech/kt20020513_166.xml.bak
? kernel-traffic/trans/czech/kt20020520_167.xml.bak
? kernel-traffic/trans/czech/kt20020527_168.xml.bak
? kernel-traffic/trans/czech/kt20020603_169.xml.bak
? kernel-traffic/trans/czech/kt20020609_170.xml.bak
? kernel-traffic/trans/czech/kt20020617_171.xml.bak
? kernel-traffic/trans/czech/kt20020624_172.xml.bak
? kernel-traffic/trans/czech/kt20020708_174.xml.bak
? kernel-traffic/trans/czech/kt20020715_175.xml.bak
? kernel-traffic/trans/czech/kt20020722_176.xml.bak
? kernel-traffic/trans/czech/kt20020805_178.xml.bak
? kernel-traffic/trans/czech/kt20020812_179.xml.bak
? kernel-traffic/trans/czech/kt20020819_180.xml.bak
? kernel-traffic/trans/czech/kt20020826_181.xml.bak
? kernel-traffic/trans/czech/kt20020902_182.xml.bak
? kernel-traffic/trans/czech/kt20020909_183.xml.bak
? kernel-traffic/trans/czech/kt20020916_184.xml.bak
? kernel-traffic/trans/czech/kt20020923_185.xml.bak
? kernel-traffic/trans/czech/kt20020930_186.xml.bak
? kernel-traffic/trans/czech/kt20021007_187.xml.bak
? kernel-traffic/trans/czech/kt20021014_188.xml.bak
? kernel-traffic/trans/czech/kt20021021_189.xml.bak
? kernel-traffic/trans/czech/kt20021028_190.xml.bak
? kernel-traffic/trans/czech/kt20021111_191.xml.bak
? kernel-traffic/trans/czech/kt20021118_192.xml.bak
? kernel-traffic/trans/czech/kt20021125_193.xml.bak
? kernel-traffic/trans/czech/kt20021202_194.xml.bak
? kernel-traffic/trans/czech/kt20021209_195.xml.bak
? kernel-traffic/trans/czech/kt20021216_196.xml.bak
? kernel-traffic/trans/czech/kt20021223_197.xml.bak
? kernel-traffic/trans/czech/kt20021230_198.xml.bak
? kernel-traffic/trans/czech/kt20030106_199.xml.bak
? kernel-traffic/trans/czech/kt20030113_200.xml.bak
? kernel-traffic/trans/czech/kt20030117_201.xml.bak
? kernel-traffic/trans/czech/kt20030124_202.xml.bak
? kernel-traffic/trans/czech/kt20030131_203.xml.bak
? kernel-traffic/trans/czech/kt20030209_204.xml.bak
? kernel-traffic/trans/czech/kt20030216_205.xml.bak
? kernel-traffic/trans/czech/kt20030223_206.xml.bak
? kernel-traffic/trans/czech/kt20030302_207.xml.bak
? kernel-traffic/trans/czech/kt20030309_208.xml.bak
? kernel-traffic/trans/czech/kt20030316_209.xml.bak
? kernel-traffic/trans/czech/kt20030323_210.xml.bak
? kernel-traffic/trans/czech/kt20030330_211.xml.bak
? kernel-traffic/trans/czech/kt20030406_212.xml.bak
? kernel-traffic/trans/czech/kt20030413_213.xml.bak
? kernel-traffic/trans/czech/kt20030428_214.xml.bak
? kernel-traffic/trans/czech/kt20030509_215.xml.bak
? kernel-traffic/trans/czech/kt20030520_216.xml.bak
? kernel-traffic/trans/czech/kt20030523_217.xml.bak
? kernel-traffic/trans/czech/kt20030607_218.xml.bak
? kernel-traffic/trans/czech/kt20030616_219.xml.bak
? kernel-traffic/trans/czech/kt20030708_221.xml
? kernel-traffic/trans/czech/kt20030710_222.xml
? kernel-traffic/trans/czech/kt20030720_223.xml
? kernel-traffic/trans/czech/kt20030730_224.xml
? kernel-traffic/trans/czech/kt20030731_225.xml
? kernel-traffic/trans/czech/kt20030805_226.xml.bak
? kernel-traffic/trans/czech/kt20030811_227.xml
? kernel-traffic/trans/czech/kt20030817_228.xml
? kernel-traffic/trans/czech/kt20030908_229.xml
? kernel-traffic/trans/czech/kt20030909_230.xml
? kernel-traffic/trans/czech/kt20030910_231.xml
? kernel-traffic/trans/czech/kt20030920_232.xml
? kernel-traffic/trans/czech/kt20031004_233.xml
? kernel-traffic/trans/czech/kt20031006_234.xml
? kernel-traffic/trans/czech/kt20031024_235.xml
? kernel-traffic/trans/czech/kt20031026_236.xml
? kernel-traffic/trans/czech/kt20031026_237.xml
? kernel-traffic/trans/czech/kt20031027_238.xml
? kernel-traffic/trans/czech/kt20031101_239.xml
? kernel-traffic/trans/czech/kt20031109_240.xml
? kernel-traffic/trans/czech/kt20031116_241.xml
? kernel-traffic/trans/czech/kt20031124_242.xml
? kernel-traffic/trans/czech/kt20031201_243.xml
? kernel-traffic/trans/czech/kt20031208_244.xml
? kernel-traffic/trans/czech/kt20031214_245.xml
? kernel-traffic/trans/czech/kt20031226_246.xml
? kernel-traffic/trans/czech/kt20031231_247.xml
? kernel-traffic/trans/czech/kt20040120_248.xml
? kernel-traffic/trans/czech/kt20040127_249.xml

This is a much larger list of over 700 files.

Be well,
Zack

>=20
> --=20
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylo=
r
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Zack Brown
